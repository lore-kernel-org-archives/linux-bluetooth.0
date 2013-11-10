Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1384030812.3880.47.camel@nuvo>
References: <1383938500.3880.23.camel@nuvo>
	<1384017476.3880.40.camel@nuvo>
	<CABBYNZJtvdd0iDmcuUe7S9mi68U1nQOLTy577vu0T-kpa9wMBA@mail.gmail.com>
	<1384030812.3880.47.camel@nuvo>
Date: Sun, 10 Nov 2013 02:49:28 +0200
Message-ID: <CABBYNZJyKT65rUxdhtkQit3ok4Y7khHF0qjROL1-0YzZUUbMiA@mail.gmail.com>
Subject: Re: obexd broken for absolute paths
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Bastien Nocera <hadess@hadess.net>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastian,

On Sat, Nov 9, 2013 at 11:00 PM, Bastien Nocera <hadess@hadess.net> wrote:
> On Sat, 2013-11-09 at 20:35 +0200, Luiz Augusto von Dentz wrote:
>> Hi Bastian,
>>
>> On Sat, Nov 9, 2013 at 7:17 PM, Bastien Nocera <hadess@hadess.net> wrote:
>> > On Fri, 2013-11-08 at 20:21 +0100, Bastien Nocera wrote:
>> >> Heya,
>> >>
>> >> I was trying to test gnome-user-share's Bluetooth support for BlueZ 5,
>> >> and was quite surprised it didn't work one bit, with transfers failing
>> >> as soon as they were created.
>> >>
>> >> I made this simple change to test/simple-obex-agent so you could
>> >> replicate the failure. Obviously, change the download path to exist on
>> >> your system:
>> >> -               return properties['Name']
>> >> +               return ("%s/%s" % ("/home/hadess/Downloads/", properties['Name']))
>> >>
>> >> This will see OBEX Push transfers fail as soon as accepted.
>> >
>> > Turns out this is a feature of filesystem plugin in obexd, and a bit of
>> > a problem as well:
>> > - There's no way to change the folder without changing the service file
>>
>> Yep, I remember discussing with Gustavo Padovan that this should
>> probably be set by the agent upon registration.
>
> I thought about that, but it's really a security issue. obexd might be
> running in a different context than the "application" telling it where
> to write. For example, my share application might be restricted to write
> new files in ~/Downloads, but could tell obexd to write to ~/.ssh/etc.

If obexd is running with a different user then yes, but I don't think
this is the case otherwise we should pass fd not a path since the
files should really belong to the agent not obexd.

>> > - It doesn't default to use the XDG_RUNTIME_DIR
>>
>> That is a good default considering we don't implement the change
>> above, otherwise for auto accept I believe tmp is usually a better
>> option.
>
> This is what I intend to use in gnome-user-share. obexd would write
> files with unique filenames to /run/user/<id>/obexd and move it
> ~/Downloads after uniquifying the name (eg. sending 2 files called
> "foo.jpg" should give me 2 files, not overwrite the first one as it does
> now).

Not sure what is the point of doing this, except if you want to use
tmpfs while downloading and only really store on disk when the
transfer is complete, overwrite is agent problem to select different
path if the file already exist or alert the user it will overwrite.


-- 
Luiz Augusto von Dentz
