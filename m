Return-Path: <bluez-users-bounces@lists.sourceforge.net>
In-Reply-To: <1150657050.8816.15.camel@localhost>
References: <0B0B4E49-71C5-4D33-A5E6-6304B2EFDA7F@ciziunas.com>
	<1150657050.8816.15.camel@localhost>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: multipart/mixed; boundary=Apple-Mail-2-554778987
Message-Id: <7D0614E0-109E-4E3F-9017-79874501E212@ciziunas.com>
From: =?UTF-8?Q?Vincas_=C4=8Ci=C5=BEi=C5=ABnas?= <vincas@ciziunas.com>
Date: Sun, 18 Jun 2006 15:57:50 -0400
To: BlueZ users <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] Samsung T809/D820 association issues.
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net


--Apple-Mail-2-554778987
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	delsp=yes;
	format=flowed


When I try to get the computer to initiate, I get a "connection  
refused".  Attached is the hcidump output of an  "echo ATZ > /dev/ 
rfcomm0" , which does result in "rfcomm0: connection refused".  I did  
"Authorize" the linux box from the phone's menu, so I'm still  
somewhat confused as to why it's denying.  Thanks again.

--Vincas


--Apple-Mail-2-554778987
Content-Transfer-Encoding: base64
Content-Type: application/octet-stream;
	x-unix-mode=0755;
	name="test2"
Content-Disposition: attachment;
	filename=test2

EQAAAIKvlURHFwsAAQUEDVPFDNsWABjMAgAAAAAHAAEAgq+VRJk2CwAEDwQAAQUEDgABAISvlUTX
xQAABAMLACkAU8UM2xYAAQARAAAAhK+VRMLHAAACKSAMAAgAAQACAQQAAwBAAAgAAACEr5VES8kA
AAENCAQpAA8ACAABAISvlURD3QAABBMFASkAAQAGAAEAhK+VRAnlAAAEGwMpAAUJAAEAhK+VRL3w
AAAEDgYBDQgAKQAVAAEAhK+VRHb8AAACKSAQAAwAAQADAQgARwBAAAAAAAAVAAAAhK+VRMv9AAAC
KSAQAAwAAQAEAggARwAAAAECAAQVAAEAhK+VREYEAQACKSAQAAwAAQAEAQgAQAAAAAECPgYTAAAA
hK+VRNEFAQACKSAOAAoAAQAFAQYARwAAAAAACAABAISvlUTOFwEABBMFASkAAQAIAAEAhK+VRJwf
AQAEEwUBKQABABMAAQCEr5VEXCsBAAIpIA4ACgABAAUCBgBAAAAAAAANAAAAhK+VRGAxAQACKSAI
AAQARwADPwEcCAABAISvlUS/RgEABBMFASkAAQANAAEAhK+VRO2UAQACKSAIAAQAQAADcwHXFwAA
AISvlUSilgEAAikgEgAOAEcAA+8VgxEC8AcA+wMAB3AIAAEAhK+VRAu0AQAEEwUBKQABAA0AAQCE
r5VE+7sBAAIpIAgABABAAAsPAWYNAAAAhK+VRGbDAQACKSAIAAQARwADUwH9EQAAAISvlUQwxQEA
AikgDAAIAAEABgMEAEcAQAAIAAEAhK+VREPbAQAEEwUBKQABAAgAAQCEr5VE++IBAAQTBQEpAAEA
DQABAISvlUSZ4wEAAikgCAAEAEAAA3MB1xEAAQCEr5VE5+wBAAIpIAwACAABAAcDBABHAEAABwAA
AIavlURV5wEAAQYEAykAEwcAAQCGr5VEB/0BAAQPBAABBgQHAAEAhq+VRCEgAgAEBQQAKQAW

--Apple-Mail-2-554778987
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed






On Jun 18, 2006, at 2:57 PM, Marcel Holtmann wrote:

> Hi Vincas,
>
>> I am having trouble getting my Samsung phone to permit my linux box
>> to use it as an rfcomm device.  The phone in question is a Samsung
>> t809.  From what I can tell, the phone attempts to authenticate to
>> the computer with the pin I gave it, it then successfully pairs, and
>> tries "Getting a service list...".  This is where things go wrong.
>> The phone errors out with a "Service not found".  It then refuses to
>> permit me to authorize the computer to use it as an rfcomm device.  I
>> think it the latter has everything to do with some flawed logic that
>> the phone designers had that if it gets a "Service not found", it is
>> not really paired with the device.  Attached is an hcidump output,
>> perhaps someone more intelligent than myself can enlighten me on what
>> I can do to handle this situation?  Thanks!
>
> I only see connections from the phone to your Linux box and thus it is
> totally okay that it asks for supported services and disconnects if it
> doesn't find any. Establish the connection from the Linux box.
>
> Regards
>
> Marcel
>
>
>
>
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>


--Apple-Mail-2-554778987
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--Apple-Mail-2-554778987
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--Apple-Mail-2-554778987--
