Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Sat, 27 Jan 2007 03:58:32 -0800
From: Andres Vargas - zodman <zod@linuxmerida.org>
To: bluez-users@lists.sourceforge.net
Message-ID: <20070127035832.4aecaae8@localhost.localdomain>
In-Reply-To: <2e9fc96f0701252321k59b0320cld9eef725a6cc06ac@mail.gmail.com>
References: <2e9fc96f0701252321k59b0320cld9eef725a6cc06ac@mail.gmail.com>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Obex File Transfers between Nokia and BlueZ
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

try enable piscan on your bt


# hciconfig hci0 piscan

i have a nokia 6670 and i push files with ..


#  ussp-push 00:02:5B:00:A5:A5@12 file file

your  OBEX Object Push is on channel 9 try with 

#  ussp-push 00:02:5B:00:A5:A5@9 file file




On Fri, 26 Jan 2007 12:51:17 +0530
"Prabhu nath" <gprabhunath@gmail.com> wrote:

> Dear All,
>            This is the 2nd time I am posting the question with more
> experiments and more logs.
>            Has anyone tried obex file transfers between Nokia and BlueZ.
> I tried with following Nokia series. In all of these I was not able to Push
> a file from the Cell Phone to my Computer with BlueZ. I can push/pull a file
> from BlueZ to Cell Phone
> Nokia 6260
> Nokia 6681
> Nokia N80
> Nokia E61
> Nokia N93.
> 
> On the contrary, Object Push works well with MotoQ.
> 
> Here is the configuration of BlueZ :
>                    http://brochevarevarura.googlepages.com/bluezconf
> 
> Logs of Obj. Push from Nokia to BlueZ :
>                    http://brochevarevarura.googlepages.com/N93_to_BlueZ.htm
> 
> Logs of Obj. Push from MotoQ to BlueZ :
>                   http://brochevarevarura.googlepages.com/MotoQ_to_BlueZ.htm
> Observation :
>               In case of MotoQ, L2CAP is connection is getting disconnected
> after SDP
>               negotiation and again reconnecting for the Obex file
> transfer.
>               whereas In case of Nokia, L2CAP connection is not getting
> disconnected after SDP
>               Negotiation.
> 
> This comparision is based on Observation, but I am not aware of rationale
> behind this behaviour.
> 
> If anyone has successfully tried out Object Push from Nokia, can you please
> get me the configuration and the operation.
> Appreciate your help in fishing out the problem.
> 
> Thanks,
> Prabhu


-- 

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
