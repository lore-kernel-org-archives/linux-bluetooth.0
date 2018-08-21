Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1534799268.5879.34.camel@intel.com>
References: <CAEwN+MBjU=ZmbVyppH6_t45ZLaCRe_8FE7XFDSCnDoSBKKrAag@mail.gmail.com>
 <1534714610.5879.11.camel@intel.com> <CAEwN+MC+33Te21rHpKVcE0HV1c_zugJ1FVR+2uj1vcBrygUQBg@mail.gmail.com>
 <1534792605.5879.17.camel@intel.com> <CAEwN+MBxzZg8UyeqTfRPizfzjH07iD6_hL=7UPxHw1ZnOC8gMA@mail.gmail.com>
 <1534799268.5879.34.camel@intel.com>
From: Raul Piper <raulpblooper@gmail.com>
Date: Tue, 21 Aug 2018 13:29:53 +0530
Message-ID: <CAEwN+MD_MxqKp0Lfn6H-YNNa99x7Wme_du9+2myyA_5Xrj690A@mail.gmail.com>
Subject: Re: Failed to parse provisioning database file prov_db.json :
 BlueZ,Meshctl V5.50
To: "Stotland, Inga" <inga.stotland@intel.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Inga,


On Tue, Aug 21, 2018 at 2:37 AM, Stotland, Inga <inga.stotland@intel.com> wrote:
> Hi Raul,
>
> On Tue, 2018-08-21 at 01:14 +0530, Raul Piper wrote:
>> Hello Inga,
>> Attached,
>> Rgds,
>> Rp
>>
>> On Tue, Aug 21, 2018 at 12:46 AM, Stotland, Inga
>> <inga.stotland@intel.com> wrote:
>> > Hi Raul,
>> >
>> > On Tue, 2018-08-21 at 00:13 +0530, Raul Piper wrote:
>> > > Hello Inga,
>> > > it gives the below logs :
>> > >
>> > > pi@raspberrypi:~/blueZ $ meshctl -c mesh
>> > >
>> > > Failed to parse local node configuration file
>> > > mesh/local_node.json
>> > >
>> > >
>> > >
>> > > pi@raspberrypi:~/blueZ $ meshctl -v
>> > >
>> > > meshctl: 5.50
>> > >
>> > > i need to do export before executing above commands
>> > >
>> > > pi@raspberrypi:~ $ LD_LIBRARY_PATH=/usr/local/lib
>> > >
>> > > pi@raspberrypi:~ $ export LD_LIBRARY_PATH
>> > >
>> > >
>> > >
>> > > to avoid the below error :
>> > >
>> > > pi@raspberrypi:~ $ meshctl -v
>> > >
>> > > meshctl: error while loading shared libraries: libjson-c.so.4:
>> > > cannot
>> > > open shared object file: No such file or directory
>> > >
>> > >
>> > > can you please assist?
>> > > or any  experimental patch I could use on BlueZ
>> > >
>> > > Thanks in advance
>> > > Best Regards,
>> > > Rp
>> > >
>> > > On Mon, Aug 20, 2018 at 3:06 AM, Stotland, Inga <inga.stotland@in
>> > > tel.
>> > > com> wrote:
>> > > > Hi Raul,
>> > > > On Sun, 2018-08-19 at 03:03 +0530, Raul Piper wrote:
>> > > > > Hello ,
>> > > > > I have built and BlueZ 5.50 from the source and installed it
>> > > > > on
>> > > > > raspberry PI 3 W0, but when I am trying to launch the meshctl
>> > > > > tool -
>> > > > > using ./meshctl (from within or out side the mesh directory)
>> > > > > i am
>> > > > > getting the below error  :
>> > > > >
>> > > > > Failed to parse provisioning database file prov_db.json
>> > > > >
>> > > > > I checked the online sanity onfthe above json file and it
>> > > > > seems
>> > > > > correct.
>> > > > >
>> > > > >
>> > > > >
>> > > > > I tried doing the sudo hcitool -lescan - it shows the LE
>> > > > > devices
>> > > > > and also
>> > > > >
>> > > > > bluetoothd -v gives 5.50 which shows my compilation and
>> > > > > loading
>> > > > > of the
>> > > > > new BlueZ is alteast correct.
>> > > > >
>> > > > > I have already installed the c-json lib .
>> > > > >
>> > > > > Is this a bug in meshctl?
>> > > > >
>> > > > > Please assist !
>> > > > >
>> > > > >
>> > > > > Thanks in Advance !
>> > > >
>> > > > Are you using the default json file? If so, there's a bug in
>> > > > meshctl
>> > > > for reading from default location (just subimmted a patch for
>> > > > that).
>> > > >
>> > > > Meanwhile, try running:
>> > > >  ./meshctl -c mesh
>> > > >
>> > > > Regards,
>> > > > Inga
>> > > >
>> >
>> > I am not an expert on system setup, but could you please run
>> > sudo /sbin/ldconfig -v
>> >
>> > Regards,
>> > Inga
>>
>>
>
> There is no record of libjson-c in your ldconfig output. So my guess
> would be that something is to do with the installation of json-c
> library on rpi.
>
> If you had to build the json-c from source and then run make install,
> you may want to modify the installation path to be something standard
> on your system from where ldconfig will be able to pick it up.
> ./configure --prefix=/somewhere/not/usr/local prior to make install
>
> Alternatively, you may try to run this command:
>
>  ldconfig -l /path-to-libjson-c.so.xxx
>
> Re-run ldconfig afterwards and see if the libjson-c showed up.
>
> Regards,
>
> Inga
>
> P.S. Just FYI, the standard way to respond to emails on bluez mailing
> list is to include the body of you reply at the tail of the message.
>

Sorry for Top posting.
I reinstalled the blueZ  (with --enable-mesh) , installed json-c from the git
I can see the entry of the libjson-c unlike previously but it still
gives the same error.
Don't we have to link the libjson-c with the BlueZ while building by
setting some Linker flags(LD) in the Makefile of the BlueZ.Is there
any such option?
How will I come to know that it has built successfully with the
reference to the libjson-c.
I believe we must have json-c pre-installed before building the  BlueZ
and Build setup of BlueZ must know where is the libjson-c.

Rgards,
Rp
