Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <44980E00.1060909@cormack.org>
Date: Tue, 20 Jun 2006 16:02:24 +0100
From: Alec <bluez@cormack.org>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
References: <4496DADD.5050208@cormack.org>
	<1150797337.18381.35.camel@localhost>
	<4497E167.3020205@cormack.org>
	<1150811813.18381.44.camel@localhost>
In-Reply-To: <1150811813.18381.44.camel@localhost>
Subject: Re: [Bluez-users] Bluez NAP refuses connection if PANU clent has
 deleted pairing.
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

Hi Marcel

Once I removed auth and encrypt from hcid.conf everything works fine.

Just to be on the safe side I downloaded the latest bluez-utils I could 
find for the NSLU2 (2.25) device anyway.

Thanks for your help

Alec

Marcel Holtmann wrote:
> Hi Alec,
>
>   
>> Thanks for the reply.  I will try to get a later version of bluez-utils 
>> then update the mailing list with the outcome.
>>     
>
> always reply to the mailing list. There is no point in moving this to a
> private discussion.
>
>   
>> I just wanted to clarify one point first about not using auth and 
>> encrypt (mode 3). 
>>     
>
> If you set auth and encrypt in hcid.conf (which got removed in
> bluez-utils-3.1 btw) then you are in security mode 3. You really don't
> wanna do that and for the why you simply look at the mailing list
> archive, because this has been discussed multiple times.
>
>   
>> Do you mean just that I shouldn't use them in hcid.conf and only use 
>> them when I start the pand daemon?  Or is there some problem using both 
>> options together?
>>     
>
> The pand has the options -A (for auth) and -E (for encrypt) and this
> gives you security mode 2 which is what you really want.
>
> Regards
>
> Marcel
>
>
>
>
>   


______________________________________________________________________
This email has been scanned by the MessageLabs Email Security System.
For more information please visit http://www.messagelabs.com/email 
______________________________________________________________________


_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
