Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Michal Semler (volny.cz)" <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] new bthid and switching off sensor in mouse???
References: <200404021906.54779.cijoml@volny.cz> <200404030054.21634.cijoml@volny.cz> <1080964638.3456.8.camel@pegasus>
In-Reply-To: <1080964638.3456.8.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <200404031108.59037.cijoml@volny.cz>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sat, 3 Apr 2004 11:08:58 +0200

Dne so 3. dubna 2004 05:57 Marcel Holtmann napsal(a):
> Hi Michal,
>
> > cvs up -D "23 days ago" libs2 utils2
>
> the time range of 23 days was here important, because I didn't know
> about what source you were talking ;)

OK :)

>
> Actually I diffed them and for the library the only change I see is the
> support for big endian. The change in the bthid program was only for the
> udev created device node of uinput.
>
> You don't tried the bthidd or bthidc program, do you?

No. It strange, I tried it again and problem is still here? Can't it be 
problem in endian changes in libs?

Michal


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
