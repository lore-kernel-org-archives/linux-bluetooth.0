Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <b92d97be0704241617x18ce730x3d319020ba935c33@mail.gmail.com>
Date: Wed, 25 Apr 2007 08:47:33 +0930
From: "Adam Dixon" <adamtdixon@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <462E042D.5060405@xmission.com>
MIME-Version: 1.0
References: <b92d97be0704232057m648388a9w1748fe6312d25164@mail.gmail.com>
	<462E042D.5060405@xmission.com>
Subject: Re: [Bluez-users] headset and input noise
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hello Walt, Brad.

> may sound silly but did you mute 'line' in alsamixer? If you have a device it can
> cause static. I have a TV card. You may have a capture builtin your laptop.

I have not muted the linein (my laptop has onboard line in) - this
might be something to look into.

On 4/24/07, Brad Midgley <bmidgley@xmission.com> wrote:
> are you using the sco flowcontrol kernel patch from the plugz module
> under the patches directory?
>
> brad

I have seen mention this flow control patch. However I see no help in
applying it. I have FC6 and kernel source installed, do I just apply
the file using patch to my sources? then recompile plugz and sbc? or
is there more to do than that?

Some quick steps on outlining how to apply the patch would be really
appreciated, I have googled and found no-such blog or howto. Ive only
ever used patch on a single file also - which adds to my confusion.
And is it V4.2 that I use?

Thanks allot for any help.

Adam

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
