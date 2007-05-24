Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <46552B55.1040206@gmail.com>
Date: Thu, 24 May 2007 09:06:13 +0300
From: bhairava <bhairavah@gmail.com>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <E1Hr6Sk-00031h-Rv@mail.sourceforge.net>
In-Reply-To: <E1Hr6Sk-00031h-Rv@mail.sourceforge.net>
Subject: Re: [Bluez-users] auth problems
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

solved it.

hcid pass is for incoming connections.
i was doing outgoing.
managed to make it work with help of the example passkey-agent in 
bluez-utils. i don't understand why this only comes as a source file and 
not installed by default, as it should be. oh well.


Aveek Audhya wrote:
> I am using FC6, kernel 2.6.20-1. I have tested with setting the security to
> none in hcif.conf. In this case my Nokia 6600 doesn't ask for any
> password(pin) while doing Obex File Transfer.
>
> -----Original Message-----
> From: bhairava [mailto:bhairavah@gmail.com] 
> Sent: Thursday, May 24, 2007 2:08 AM
> To: BlueZ users
> Subject: [Bluez-users] auth problems
>
>
> i posted to the list before, but got no answer.
>
> i am trying to obexftp some files from my nokia fone. the phone asks for 
> a password (pin).
> the problem is:
> 1. if i set security none, in hcid.conf, it still wants a password. is 
> this normal ?
> 2. if i set security auto, and passkey 1234, hcid says:
>
> hcid[11839]: pin_code_request (sba=00:0B:0D:4C:AB:C3, 
> dba=00:18:C5:38:AF:D1)
> hcid[11839]: call_passkey_agent(): no agent registered
>
> why am i setting the passkey if it doesn't read it ?
>
> 3. if i set security user, and pin_helper WHATEVER, it says at startup
> hcid[11854]: Unknown option 'pin_helper' line 25
> hcid[11854]: syntax error line 25
>
> and if i try to connect,
> hcid[11854]: pin_code_request (sba=00:0B:0D:4C:AB:C3, 
> dba=00:18:C5:38:AF:D1)
> hcid[11854]: call_passkey_agent(): no agent registered
>
> is the security setting a joke ? shouldn't that give me to option to say 
> if i even WANT to use an agent ?
>
> i use debian 4.0 with kernel 2.6.21.1 and hcid ver 3.7.
>
> thanks for any insight.
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
>
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
