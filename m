Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Missing libopenobex-1.0.so.1
From: Stuart Anderson <subscritions@nx14.com>
Reply-To: subscritions@nx14.com
To: Thomas Chiverton <thomas.chiverton@bluefinger.com>
Cc: bluez-users <bluez-users@lists.sourceforge.net>
In-Reply-To: <200403091629.40690.thomas.chiverton@bluefinger.com>
References: <1078847668.9713.2.camel@donivin.nx14.com>
	 <200403091629.40690.thomas.chiverton@bluefinger.com>
Content-Type: text/plain
Message-Id: <1078873320.12219.0.camel@donivin.nx14.com>
Mime-Version: 1.0
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
Date: Tue, 09 Mar 2004 23:02:00 +0000

Thanks man that was my problem, the LD_LIBARY_PATH was empty

On Tue, 2004-03-09 at 16:29, Thomas Chiverton wrote:
> On Tuesday 09 Mar 2004 15:54 pm, you said:
> >    Can anyone tell me how i can get the ObexSERVER to run?
> 
> Have you run ldconfig -v ?
> Does it find the libary ?
> Is your LD_LIBARY_PATH / ld.so.conf correct ?
-- 
Anderson


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
