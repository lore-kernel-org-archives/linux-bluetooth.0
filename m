Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <44CDFF2D.9060003@unina.it>
Date: Mon, 31 Jul 2006 15:01:33 +0200
From: Marcello Cinque <macinque@unina.it>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <448D9B2F.8010706@unina.it>
	<1150540477.17539.31.camel@aeonflux.holtmann.net>
In-Reply-To: <1150540477.17539.31.camel@aeonflux.holtmann.net>
Content-Type: multipart/mixed; boundary="------------090004070402090001070608"
Subject: Re: [Bluez-devel] Fwd:  hci connect and switch role modifications
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------090004070402090001070608
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mail.unina.it id
	k6VD1VB8030127

Hi Marcel,

as you asked, i'll send you the modifications separately.

This is the first.
Basically, we added a  mechanism that may use to prevent some errors=20
from occurring (error masking mechanism) when performing a=20
hci_create_connection. The mechanism is part of the results of our=20
research on bluetooth networks. Perhaps the same strategies  can  be =20
generalized and applied  on several parts of the code in order to=20
improve the overall robustness of the BlueZ stack.
Specifically we added a function to the hci.c file (and related=20
hci_lib.h) which name is hci_create_connection_timed.
This function first creates a connection and then checks whether the=20
handle is valid (>0) until a given timeout expires. The timeout is=20
specified as an additional parameter, in milliseconds. We created this=20
function because, while working with bluetooth, we noticed that to get a=20
valid handle over a connection may take some time, even after that the=20
hci_create_connection function return, due to the asynchronous nature of=20
the connection creation process. This could result in a error when=20
subsequent calls are performed over the connection with a handle that is=20
still not valid (e.g. a bnep create connection call over an already=20
created l2cap connection, or a switch role command). This function=20
avoids this problem because it returns with no errors only if the=20
created connection has a valid handle.
It is worth noting that the function returns a "timer expired (ETIME)"=20
error even when the connection is created. This happens when the timeout=20
expires but the connection still has a not valid handle. However, the=20
handle could become valid after the function exits.

We preferred to provide a new function rather than modifying the=20
original ones. This way the user can choose to use the function that=20
better suites his requirements.

In order to test and use the new functionalities, we also slightly=20
modified the hcitool.c program, so as to add an optional parameter=20
"--timeout" to the "cc" command. If the parameter is specified the new=20
functions are called, otherwise the original functions are used.

Let me know if this can be of interest, in which case I'll send you also=20
the second modification, on the switch role command.

Best regards,
Marcello Cinque
Fabio Cornevilli
Mobilab Research Group - www.mobilab.unina.it



Marcel Holtmann wrote:

>Hi Marcello,
>
> =20
>
>>in february I sent you the email in the following, about some proposed=20
>>modifications in the HCI connect and switch role APIs. At that time, I =
also attached=20
>>you the unified diff files, which I'm attaching also now.
>>Anyway, I didn't receive any reply. Do you think these modifications ar=
e=20
>>likely to be integrated in next releases?
>>   =20
>>
>
>I might have missed that. Sorry, but this can happen from time to time.
>
>If you propose multiple changes then please split them and post them
>separately if possible. This makes it easier for me to review them and
>then integrate them.
>
>Regards
>
>Marcel
>
>
>
>
>_______________________________________________
>Bluez-devel mailing list
>Bluez-devel@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/bluez-devel
>
> =20
>


--=20
Marcello Cinque, PhD Candidate
Dipartimento di Informatica e Sistemistica
Universit=E0 di Napoli Federico II
Via Claudio, 21 - 80125 Napoli, Italy
Ph:  +39-081-7683874
Fax: +39-081-7683816
Web: wpage.unina.it/macinque
The MobiLab Group - www.mobilab.unina.it=20


--=20
Il messaggio e' stato analizzato alla ricerca di virus o
contenuti pericolosi da MailScanner, ed e'
risultato non infetto.


--------------090004070402090001070608
Content-Type: application/gzip;
 name="bluez_patches.tar.gz"
Content-Disposition: inline;
 filename="bluez_patches.tar.gz"
Content-Transfer-Encoding: base64

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
ila0ohWtaEXfmf4G8zmdJAAoAAA=

--------------090004070402090001070608
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--------------090004070402090001070608
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--------------090004070402090001070608--
