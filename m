Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-Id: <ICGZCE$7DF6A31DCAD3E31E3169B51A8859A4C6@bol.com.br>
Subject: Re:[Bluez-devel] BlueZ on CSR ?
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
From: "ra002890" <ra002890@bol.com.br>
To: "bluez-devel" <bluez-devel@lists.sourceforge.net>
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Fri, 25 Feb 2005 10:41:02 -0300

Can you configure your module(home made) or it is a shop-self module?!? I=
 worked with csr modules and Bluez worked very well with them. At first r=
emember that common PCs serial port works only at 115200 bps or  less. Tr=
y "hciattach ttyS0 any 115200", or
"hciattach ttyS0 bcsp 115200". If you can change PSKEYS, and firmware, re=
call me.

                                                  Daniel Moraes, directly=
 from Brasil. 



---------- In=EDcio da mensagem original -----------

      De: bluez-devel-admin@lists.sourceforge.net
    Para: bluez-devel@lists.sourceforge.net
      Cc: 
    Data: Thu, 24 Feb 2005 15:10:43 -0800 (PST)
 Assunto: [Bluez-devel] BlueZ on CSR ?

> I am doing a project at Bournemouth University, UK. I am using Gennum c=
orporations GR2320 bluetooth modules.  These modules have BlueCore HCI so=
ftware stack embedded onto the module.
>  
> I have installed BlueZ on linux (mandrake 10.0 official). My host PC is=
 a laptop - HP NX9005. But i am not able to connect to the module via the=
 RS232 interface (UART)..... Is it because blueZ does not yet support CSR=
?
>  
> Please can any one answer my query, coz i am very desperate to demonstr=
ate bluetooth connection between two bluetooth devices using the GR2320 B=
luetooth module
>  
> sincerely,
> prasanna
> 
> __________________________________________________
> Do You Yahoo!?
> Tired of spam?  Yahoo! Mail has the best spam protection around 
> http://mail.yahoo.com =0A =0A__________________________________________=
________________________________=0AAcabe com aquelas janelinhas que pulam=
 na sua tela.=0AAntiPop-up UOL - =C9 gr=E1tis!=0Ahttp://antipopup.uol.com=
.br/=0A=0A



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
