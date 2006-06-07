Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <44872289.1020100@free.fr>
Date: Wed, 07 Jun 2006 21:01:29 +0200
From: Fabien Chevalier <fabchevalier@free.fr>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <44859F7F.7060307@xmission.com>
In-Reply-To: <44859F7F.7060307@xmission.com>
Subject: Re: [Bluez-devel] Fabien Chevalier's plugin in cvs
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


Hi all,

> Hi
> 
> Fabien Chevalier's plugin that moves sco audio handling to userspace is
> now in our cvs. We hope it will be more convenient for people to track
> and work with us on it this way. Email your comments and patches here to
> bluez-devel.
> 
> Fabien was calling it 'bluez-headset' and for now I've renamed it to
> 'alsa-plugin-sco' since everything we have could be described as
> bluez-headset :)

Yes, however i have the advantage that i am the only one targetting 100% 
of headset profile. :-)
However i would tend to agree with the fact that it is just misleading 
for the end user to have something called bluez-headset that cannot 
handle his brand new stereo (a2dp) headset :-)

At the end of the day we will have to find a better name, and rename 
some files to have something coherent at the end... However it's really 
not really important for now, and alsa-plugin-sco will be just fine for 
now :-)

Fabien


_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
