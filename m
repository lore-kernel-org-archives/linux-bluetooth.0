Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Michal Semler (volny.cz)" <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: Gareth Reakes <gareth@apache.org>
Subject: Re: [Bluez-users] Problems with MS mouse and keyboard
References: <20031105093947.J63252@minotaur.apache.org> <1069884432.9032.65.camel@pegasus> <20031126141037.D25686@minotaur.apache.org>
In-Reply-To: <20031126141037.D25686@minotaur.apache.org>
Cc: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <200311262320.14302.cijoml@volny.cz>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 26 Nov 2003 23:20:14 +0100

Hi Gareth,

maybe Marcel should fetch and release from CVS his=20

hid-0.0.0.1-verysoon-notstable-onlyforinsane-prealfa version :)

Then will much more people test it and we'll get more feedback from users...

Marcel what do you think about it? :)

Michal

Dne st=F8eda 26 listopad 2003 23:13 jste napsal(a):
> Hi,
>
> On Wed, 26 Nov 2003, Marcel Holtmann wrote:
> > Hi Gareth,
> >
> > > 	I know the ping thing works, however I don't believe that it
> > > should be necessary. I think there is either something wrong with the
> > > hardware, bthid or bluez. If it is bthid or bluez then I would like to
> > > try and fix it so we can all benefit :)
> >
> > look at my bthid code and see how I have handled it. This was working
> > for me. You need a sleep() and the correct order of closing the L2CAP
> > channels. Otherwise the ACL connection would not be terminated.
>
> I modified my bthid code after you posted the other week. It still does
> not work.  Ah well, this just gives me more incentive to work on the
> kernel HID parser :) I will speak again after I have read your posting on
> devel and had a go at implementing it.
>
>
> Cheers,
>
> Gareth



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
