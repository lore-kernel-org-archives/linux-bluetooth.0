Return-Path: <cyrus@holtmann.org>
Date: Mon, 14 Jul 2008 14:18:12 -0600
From: Robert Moskowitz <rgm@htt-consult.com>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Message-ID: <487BB484.2010503@htt-consult.com>
In-Reply-To: <487B6E48.70807@htt-consult.com>
References: <487B6E48.70807@htt-consult.com>
MIME-Version: 1.0
Subject: Re: [Bluez-users] Centos/RHEL has old version of Bluez -- what to
	do?
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Robert Moskowitz wrote:
> I am using Centos 5.2.  It has bluez-utils-3.7-2*
>   
And now I realize that there are bluez kernel modules. And I can expect 
that to move to anything more recent (and stable) with bluez, would 
require a kernel compile. Not something I woudl attempt.

argh.
> I realize this is quite old and I have a lot of bluetooth plans.
>
> I would like to update to a more current bluez version, but have a 
> number of concerns.  Like the impact on my other bluez rpms:
>
> bluez-gnome-0.5-5.fc6.i386.rpm
> bluez-hcidump-1.32-1.i386.rpm
> bluez-libs-3.7-1.i386.rpm
> bluez-utils-3.7-2.el5.centos.i386.rpm
> bluez-utils-cups-3.7-2.el5.centos.i386.rpm
> gnome-bluetooth-0.7.0-10.2.el5.i386.rpm
> gnome-bluetooth-libs-0.7.0-10.2.el5.i386.rpm
>
>
> I suppose if I knew what I was doing enough to rebuild all these rpms, I 
> could get this to work.  So I have a few questions:
>
> I want to use Asterisk's chan_mobile that pairs the system to a 
> bluetooth phone for a cellular trunk.
> I want to run a PAN.
> I want a Bluetooth headset for my SIP phone and stereo for my  mp3 playing.
>
> Given these modest wants:
>
> Will it work with bluez 3.7?
> Will it be hard to get it to work and keep working with 3.7?
> Has anyone built more current rpms for Centos 5.2?
> Is anyone willing to help me built more current rpms for Centos 5.2?
>
> Thanks and good day to you all!
>
>
>
>
> -------------------------------------------------------------------------
> Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!
> Studies have shown that voting for your favorite open source project,
> along with a healthy diet, reduces your potential for chronic lameness
> and boredom. Vote Now at http://www.sourceforge.net/community/cca08
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>
>   

-------------------------------------------------------------------------
Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!
Studies have shown that voting for your favorite open source project,
along with a healthy diet, reduces your potential for chronic lameness
and boredom. Vote Now at http://www.sourceforge.net/community/cca08
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
