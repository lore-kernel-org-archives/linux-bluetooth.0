Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <3013cac80511241050o2f3d67aele639b2c69de41360@mail.gmail.com>
From: Eduardo Rocha <folhabranca@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] [DBUS Patch] Device Property
In-Reply-To: <1132805822.5982.15.camel@blade>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <3013cac80511040603k52c40da2gae5249abcba426d9@mail.gmail.com>
	 <3013cac80511171116n33c7faech6006e7264821fb16@mail.gmail.com>
	 <3013cac80511171252g4a4f1581l915e364a244ec8ea@mail.gmail.com>
	 <20051118082828.GA16438@localhost.localdomain>
	 <3013cac80511180251w1d2fa8f5s80ce1da7318327e7@mail.gmail.com>
	 <20051118112611.GA17062@localhost.localdomain>
	 <3013cac80511180500h5539d5d9y3f19ce224f9e38b7@mail.gmail.com>
	 <1132660308.28644.37.camel@blade>
	 <3013cac80511221152t2911f513jb28f3944097c1b09@mail.gmail.com>
	 <1132805822.5982.15.camel@blade>
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 24 Nov 2005 15:50:04 -0300

Hi Marcel,

maybe we should create a bluetooth group and only allow users of that
group to make write operations. I'll also check eht dbus auth to see
if that can help. Do you have in mind any operation->"security level"
map?

BR,
Eduardo.


On 11/24/05, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Eduardo,
>
> > here is the new patch. I've removed the spaces (I hope so). I've also
> > included the code for the dbus signal for the local name change event.
> > One thing that remainded open was the timeout for hci_send_req for
> > name write and name read ops. In the hciconfig this was 2s and 1s. Is
> > there a reason for this big number?
>
> you missed one whitespace/tab clash, but I fixed it. Opening a patch
> inside an editor with whitespace visualization helps a lot.
>
> The patch has been applied to the CVS and we should talk about some
> serious security setting for the D-Bus interface. Question is what a
> session user should be able to change?
>
> The timeout is not really crucial for most local configuration settings
> and I think it was a bad idea to have it in the API anyhow. However the
> change local name command is tricky. Some older CSR chips for example
> are storing the name in the PS keys, which results writing it to flash
> or EEPROM. This simply can take time.
>
> Regards
>
> Marcel
>
>
>
>
> -------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc. Do you grep through log fi=
les
> for problems?  Stop!  Download the new AJAX search engine that makes
> searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
> http://ads.osdn.com/?ad_id=3D7637&alloc_id=3D16865&op=3Dclick
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>


--
Eduardo Rocha
Instituto Nokia de Tecnologia - INdT


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
