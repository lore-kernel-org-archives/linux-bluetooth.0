Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Problems with MS mouse and keyboard
From: Marcel Holtmann <marcel@holtmann.org>
To: Gareth Reakes <gareth@apache.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20031105093947.J63252@minotaur.apache.org>
References: <20031105093947.J63252@minotaur.apache.org>
Content-Type: text/plain
Message-Id: <1068072643.1284.106.camel@pegasus>
Mime-Version: 1.0
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
Date: Wed, 05 Nov 2003 23:50:44 +0100

Hi Gareth,

> 	I tried to get this all to work about 6 months ago and could not.
> I have now tried again from scratch after the recent mail regarding this
> subject. I have everything installed and a brand spanking new 2.4.22
> kernel. I find it very difficult to connect and when I do connect it will
> not maintain the connection. I know these devices go into sleep mode, but
> talking to other people on this list, they come out of it. This is not
> possible for me. Frequently, after I try to wiggle the mouse in sleep
> mode, bthid start to take up 100% of the CPU. I find it unlikely that this
> is the bthid code itself.
> 	It is more than possible that this is a hardware problem with my
> mouse etc but I would really like to know this before trying to exchange
> them. I do have 1 more piece of information with the new kernel. As you
> can see at the end of the message below there is a message which may help.
> I am willing and able to provide whatever information will help solve this
> problem. I really do not want to lose against MS ;)

it looks like you lost the ACL link, but the mouse didn't know about
that and keeps sending you reports on that channel.

Do you get this working under Windows XP. If not, they are broken.

> PS thanks for those slides Marcel, they were informative

You are welcome :)

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
