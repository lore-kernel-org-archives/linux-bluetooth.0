Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <45642FED.1090101@free.fr>
Date: Wed, 22 Nov 2006 12:09:33 +0100
From: Fabien Chevalier <fabchevalier@free.fr>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <455C01C4.7090801@xmission.com>	<1163672537.5169.16.camel@localhost>	<455CBBA6.8040401@free.fr>	<455CCBD8.3080001@xmission.com>	<4560925E.3030901@free.fr>	<4561046E.50905@xmission.com>	<4563521A.1010707@free.fr>
	<45636960.5020207@xmission.com>
In-Reply-To: <45636960.5020207@xmission.com>
Subject: Re: [Bluez-devel] audio & dbus
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

Brad Midgley wrote:
> Fabien
> 
>> Could you provide details on why you think this was needed ?
> 
> The primary reason for a timeout is to hold the audio stream open for a
> little while after the application closes it, in case it will be used
> again soon. Under the original a2dp plugin, one a2dp set I had would
> lock up when xine rapidly opened/closed/opened/closed/opened the alsa
> device on startup.

Ok, i understood this time. :-)
Indeed i 100% agree with the behaviour that it is required, unless we 
intend to fix one by one all the applications.


> 
> There's also delay in bringing up audio that we want to avoid if
> possible since it results in the start of the stream being lost. System
> sounds tend to get lost this way.

Yes. I agree with that too.

Cheers,

Fabien

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
