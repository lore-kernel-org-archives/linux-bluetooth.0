Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <448941A4.6000205@personnelware.com>
Date: Fri, 09 Jun 2006 04:38:44 -0500
From: Carl K <carl@personnelware.com>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <44891608.2030906@personnelware.com>	<1149836904.6618.4.camel@localhost>	<44892B25.6000309@personnelware.com>	<1149840442.6618.16.camel@localhost>	<448930F9.2080306@personnelware.com>
	<1149842417.6618.30.camel@localhost>
In-Reply-To: <1149842417.6618.30.camel@localhost>
Subject: Re: [Bluez-users] PM325 by LG cell phone - pairing failed
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

Marcel Holtmann wrote:
> Hi Carl,
>
>   
>>> So since you are not emulating a headset or handsfree unit, this is not
>>> the way to go.
>>>       
>> arg - I was going to ask if it mattered which direction the pairing was 
>> done for a given profile.  I guess it does.  Now to try the other direction.
>>     
>
> for the pairing the direction doesn't matter all. You have a valid link
> key and that is enough.
>
> For using a service of your phone it does matter. If you wanna connect
> to DUN for dialup into the Internet then you don't wanna play with the
> headset support of your phone.
>   

To use DUN don't I have to pair first?

I seem to have done whatever I need to do, because I am not talking to 
it via minicom:

at&v1
&C: 1; &D: 2; &F: 0; E: 1; L: 1; M: 0; Q: 0; V: 1; X: 4; Z: 0; S0: 0
S10: 14; S11: 95; S3: 13; S4: 10; S5: 8; S6: 2; S7: 45; S8: 2; S9: 6
+FCLASS: 0; +CFG: ""; +FCC: 0,1,0,0,0,0,0,0; +FIS: 0,1,0,0,0,0,0,0
+CDR: 0; +CDS: 0,1,2048,6; +CFC: 0; +CQD: 10; +CRC: 0; +CRM: 2; +TEST: 0
+CTA: 60; +CXT: 0; +DR: 0; +DS: 3,0,2048,6; +EB: 1,0,30; +EFCS: 1
+ER: 0; +ES: 3,0,2; +ESR: 1; +ETBM: 1,1,20; +FAA: 0; +FAP: 0,0,0
+FBO: 0; +FBU: 0; +FCQ: 1,0; +FCR: 0; +FCT: 1E; +FEA: 0; +FFC: 0,0,0,0
+FHS: 0; +FIE: 0; +FIP: 0; +FLI: ""; +FLO: 2; +FLP: 0; +FMS: 0
+FNR: 0,0,0,0; +FNS: ""; +FPA: ""; +FPI: ""; +FPP: 0; +FPR: 8; +FPS: 1
+FPW: ""; +FRQ: 0,0; +FRY: 0; +FSA: ""; +FSP: 0; +ICF: 3,3; +IFC: 2,2
+ILRR: 0; +IPR: 115200; +MA: ; +MR: 0; +MS: ; +MV18R: 0; +MV18S: 0,0,0
+CMUX: C,2

OK

I don't have a modem to call, so I tried calling my cell phone.  I think 
it rebooted the phone?

Carl K


_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
