Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Michal Semler <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] /usr/include/bluetooth/bnep.h
References: <1083857533.16650.25.camel@saag> <200405062127.11184.cijoml@volny.cz> <1083877306.4420.72.camel@pegasus>
In-Reply-To: <1083877306.4420.72.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <200405062353.34156.cijoml@volny.cz>
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
Date: Thu, 6 May 2004 23:53:33 +0200

On Thursday 06 of May 2004 23:01, Marcel Holtmann wrote:
> Hi Michal,
>
> > will it include bthid and my script??
>
> not quite exactly. The init script looks a little bit different to
> better blend in and to keep the stuff from bluez-pan. You can take a
> look at it in CVS. However your question reminds me that I have to fix
> up the install routine for that script.
>
> The bthid will not be included. I already included the first rough steps
> of the new hidd, which is going to depend on the hidp kernel module.
> Right now I marked it as "noinst" and I am not quite sure if I am going
> to change that before bluez-utils-2.8. However the code is there and I
> think that I am going to release 2.6.6-mh1 with a prototype of that
> kernel module.

PLS release it in 2.7. We will happily wait for it. Longer waiting is killing 
us at all :)

Michal


-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to deliver
higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
