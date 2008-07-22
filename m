Return-Path: <cyrus@holtmann.org>
Message-ID: <4885E395.8090109@wurmsdobler.org>
Date: Tue, 22 Jul 2008 14:41:41 +0100
From: Peter Wurmsdobler <peter@wurmsdobler.org>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <4885B849.7040201@wurmsdobler.org>
	<1216730752.31819.28.camel@californication>
In-Reply-To: <1216730752.31819.28.camel@californication>
Subject: Re: [Bluez-users] #define OGF_TESTING_CMD potentially wrong?
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

Hello Marcel,
> that hcidump shows something as unknown, doesn't mean that it didn't
> work. Actually hcidump is only a passive tool like tcpdump. So feel free
> to send a patch to fix hcidump, but this doesn't mean that hcitool is
> not working.
This was my understanding, too. After issuing the command with ogf=0x06 
our test equipment could take over the module, which proved for me that 
the command had worked. However, the #define hcidump uses is defined in 
bluez-libs/include/hci.h. I will send a patch.
peter


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
