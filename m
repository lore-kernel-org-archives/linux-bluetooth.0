Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <b92d97be0704272144m715e02bj8be217a328e62ed0@mail.gmail.com>
Date: Sat, 28 Apr 2007 14:14:50 +0930
From: "Adam Dixon" <adamtdixon@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <a72d33330704260237l10d76906ma50d45cb9e0f0fb8@mail.gmail.com>
MIME-Version: 1.0
References: <b92d97be0704232057m648388a9w1748fe6312d25164@mail.gmail.com>
	<462E042D.5060405@xmission.com>
	<b92d97be0704252225n13cb3b04q8ffd2554270d224c@mail.gmail.com>
	<463052D2.3090800@xmission.com>
	<a72d33330704260237l10d76906ma50d45cb9e0f0fb8@mail.gmail.com>
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

Hello,
I have followed this guide to build kernel rpm in fedora vs
kernel-2.6.20-1.2944.fc6.src.rpm - I like Ma am struggling to get the
patch applied ok.
For those interested ( http://www.howtoforge.com/kernel_compilation_fedora )

I get the following error when building from the edited spec file.
+ echo 'Patch #8 (sco-flowcontrol-v4.2.diff):'
+ patch -p1 -s
error: Bad exit status from /var/tmp/rpm-tmp.12170 (%prep)
    Bad exit status from /var/tmp/rpm-tmp.12170 (%prep)

I defined the patch as %patch8 -p1 ( I dont know if p1 is a suitable
argument - but all other patches used p1. Is this right?)

Does this patch only work against an older kernel ? Or do I need to
place the patch in a later number. Any hints? Even if just hints to
get more debug from this process would be nice.

Thanks allot,
Adam

On 4/26/07, Ma Begaj <derliebegott@gmail.com> wrote:
> 2007/4/26, Brad Midgley <bmidgley@xmission.com>:
> >
> > >> are you using the sco flowcontrol kernel patch from the plugz module
> > >> under the patches directory?
> > >
> >
> > making a distro-friendly custom kernel differs from distro to distro, so
> > search around for fedora guides on doing a custom kernel. I don't use
> > fedora so I don't know.
> >
> > Brad
>
> Hi,
>
> I tried yesterday to patch my kernel with the
> plugz/patches/sco....v4.2.diff  and v.4-1. No chance for patch to
> succeed.
>
> I tried version 4.2 with 2.6.20.6, but a half of the patch did not
> work. I tried it with 2.6.21-rc7, again with half of the patch skipped
> ...
>
> Everything was tested with vanilla kernel without any other patches.
>
> M.
>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by DB2 Express
> Download DB2 Express C - the FREE version of DB2 express and take
> control of your XML. No limits. Just data. Click to get it now.
> http://sourceforge.net/powerbar/db2/
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
