Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <403375D2.3030703@yahoo.com>
From: "Todd E. Johnson" <tejohnson@yahoo.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Re: 2.6.2 errors with DBT-120 (B2)
References: <402E2E29.7040207@yahoo.com> <1076769794.14758.2.camel@pegasus>	 <402E4E02.9020600@yahoo.com> <1076851622.14758.22.camel@pegasus> <402F99AC.7020500@yahoo.com> <403137F9.1050108@yahoo.com> <403144AB.9040504@yahoo.com> <4031455F.6040406@yahoo.com>
In-Reply-To: <4031455F.6040406@yahoo.com>
Content-Type: multipart/mixed;
 boundary="------------010000050303090300090903"
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
Date: Wed, 18 Feb 2004 09:25:22 -0500

This is a multi-part message in MIME format.
--------------010000050303090300090903
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Howdy,

Using the patch and information I sent a few days ago, I attemted a SCO 
connection with a Sony Ericsson BT enabled handset.  I attempted to use 
the KDE BT Dialer from the KDE Bluetooth Framework. 

Attached is a file 'hci_conn.txt' which shows the device actually has a 
SCO connection, however I can not hear anything like I previously could 
with 2.4.22.  I also included 'hciconfig hci0 revision' and 'hciconfig 
hci0 voice' in this file as well. 

While I was attampting the connection, I did a 'hcidump -w hci_dump.raw' 
and have included it with this mail also.

Is the previous, as well as this,  information helpfull?

-- 

        Regards,
        
        Todd E. Johnson



--------------010000050303090300090903
Content-Type: text/plain;
 name="hci_conn.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hci_conn.txt"

Connections:
	> SCO 00:0A:D9:03:63:D0 handle 45 state 1 lm SLAVE 
	> ACL 00:0A:D9:03:63:D0 handle 41 state 1 lm SLAVE 

hci0:	Type: USB
	BD Address: 00:80:C8:1F:B0:1F ACL MTU: 192:8  SCO MTU: 64:8
	Voice setting: 0x0060 (Default Condition)
	Input Coding: Linear
	Input Data Format: 2's complement
	Input Sample Size: 16 bit
	# of bits padding at MSB: 0
	Air Coding Format: CVSD

hci0:	Type: USB
	BD Address: 00:80:C8:1F:B0:1F ACL MTU: 192:8  SCO MTU: 64:8
	HCI 15.3
	Chip version: BlueCore02
	Max key size: 56 bit
	SCO mapping:  HCI

--------------010000050303090300090903
Content-Type: application/x-gzip;
 name="hci_dump.raw.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="hci_dump.raw.gz"

H4sICCRxM0AAA2hjaV9kdW1wLnJhdwDFVltonFUQnrP/+S97TTbbbJImDWkskm02oZt1BRND
sqYF0zY2JBqlWmS7bi40SXNtLRqo1kvzUAmWolj1QR9KI1JELFYFKcUo1EttgqGoJUV8kEpT
LdaHYtcz5z9n/3+zSURfzEJgv/nmm5kzc2aPFwhcH4o2n37FB5S6LiSVSy6gjg7iBuCGra/6
gDipblqILvhfXWH8PIomJ4N+Y9DxqwC0SDOJa5k7gu2LAMRNgyZ6/0DnjO/cnq09DcPVF8ur
N3uFa9sQAepzMSKYRJ8wfLaVAlXcEBI4IYYQfmQbC+41aIhxXYI93sHYFTJVmdfDEwz1aYzM
ZKT7KQaSPMrci7/UBPHxWUYsVUKg6gLZOE/NKvOoIaD87xm0TgV09Aus5JIKjlCFB5DkIIwP
zVAoIp02jfngYbDC8m9mH/yTiuO/qkADKgmx74UCe7FIs5yow+AuxHELAkLVUcwJZu2qQxOa
fmG+0zSbGVGWUbMt4OJGLRNQYufrLCwgsI8S9hhExlgvmzbAzWVQzAwaMwRiSom/PJ2OOZ14
+tSp+CEiEhoY5+QwVDGyzsA7oCJWHitjzJjGvEoKFOYR8zAJAjG1BBRDyyT30pSVnDzzG9/Z
KtQUyo9Vln9g3mbUhVGq3X0tV+32Dt3WQUpBgXimg0fbdVsHKTYjntXB3qSe08FHX7Y5UTW3
g7MmQZyuqglNGfTPLH82AXHuD5lBfOekntPF59+zsCKBfT7HhQr4nVIdLtFFTEVev/0/cIoB
eFBKEynziiTOW4Y4KKNkXga6uWgFKhaYXmogOQB5qLK4Bg75PdcDcBNAHyoSgm+ZHEwmDmSx
8Bm/Z8GkTEvp7jojIy0T3J4wrASjTaRFJnjGMsQhOkoOywm4YRqwoRjI+ZMaPTLtE8aDgyxY
idx2xNbJq2NGzqGeetrCCgQ2d5zLe8HJazWA6XuHZPCHXs8OfoUZp6XrcyeWuDLrkSGZ2gem
1Qkqc42kyfpJuYsa3jfMXVSSGYHAx7nZnp2xMAcxsW+b2N3S02KHtu3d3defghX/rBW2dPlk
74Hlr/3KN1new6W3KHv+l27J7P1mX2fLb5Lb6ZU+OIO/4+q8bJvByGJh/MHqltYHNjc2eY+h
PFKCf1iHOCGwEzud6PYkvIEzmK4lxOvijvUVVZW7E2Njyd6eynDVpppYKBSuqhzt6xlM9NsA
pKRGDuxPjAz2DXJmOMINyd7ESE9qJLl3cDCVHEs9YTONpkb29SVTJlIrEmntxkTyQ2B6J/r7
bR4jexMD8qvX5XXt2OZ1dQZF5ekPeQl+dq+w8oCo3Fb4zDfOTOE1AqsrcKFXFWzghd8LVuF1
4Vh4E/tE8H8m3DoRbuJr7lgMa3i49RiubUtHY9T0saIGfnZl7U/EbgXccv9hVA9G5eqyjfWN
7pw2bm9tb7Tp7upy5+hWTK6ie4MRPtkFq40HUoxhyBoPxL74C/7/8cBEHnOS/zAe6PnaSbLK
eCCj9gzJGg/Epm6Rfz8e6Hh20vHP44HEp952ZLURse6LjtXbeCGgLG3jfV0d8Uab7j1hJUd3
YbeyvK5XEHw6zXoog1sEPKbTpQ9lDh+l8qHsE9CnP5qP2hqxkIE/atHSctl8ldbAAmiCPRdV
zVdpRnJfg2p/lSK0J6jxV2kNHIQgw27iD/+zYLZzDS+lDIA3ZktXvUcwDr2AjHwdsFOsRgyw
djja/GaKlaZSphYoFdDUFL/LQfYLiGLFXAwPtL6CdbZTE7T8WZd4QuMv9AaG7By1PSEineQc
poyGdw/rWb/ziN11zfYQiYySX/4G8NASr58MAAA=
--------------010000050303090300090903--


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
