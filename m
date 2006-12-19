Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Tue, 19 Dec 2006 11:47:39 +0200
From: Tuomas Suutari <thsuut@utu.fi>
In-reply-to: <1166521154.29972.4.camel@violet>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Message-id: <200612191147.39325.thsuut@utu.fi>
MIME-version: 1.0
References: <200612191103.20942.thsuut@utu.fi>
	<1166521154.29972.4.camel@violet>
Subject: Re: [Bluez-devel] rfcomm_sock_sendmsg with len==0 (in Linux 2.6.18)
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

On 2006-12-19 Tuesday 11:39, Marcel Holtmann wrote:
> > rfcomm_sock_sendmsg() in net/bluetooth/rfcomm/sock.c. It returns
> > uninitialized variable err, if called with len==0.
> >
> > Simple fix is to initialize err to 0.
>
> this would only hide the real problem. It should only return err if
> the sent is still 0. The return statement is
>
> 	return sent ? sent : err;

Yep, exactly. It returns err, which isn't initialized, so it could be 
positive.

Am I missing something?

-- 
Tuomas Suutari | +358 50 3806983 | thsuut@utu.fi

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
