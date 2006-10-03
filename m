Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Tue, 3 Oct 2006 17:33:45 +0200 (CEST)
From: Peter Wippich <pewi@gw-instruments.de>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <9cc82a4d0610030746r7039990eie8397add3559ca80@mail.gmail.com>
Message-ID: <Pine.LNX.4.63.0610031651360.5319@redbean.intranet.gw-instruments.de>
References: <9cc82a4d0610030746r7039990eie8397add3559ca80@mail.gmail.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-1463794332-1640826198-1159889625=:5319"
Subject: Re: [Bluez-devel] High speed serial connection (Was: Bluez article
 on OReillyNet)
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463794332-1640826198-1159889625=:5319
Content-Type: TEXT/PLAIN; charset=US-ASCII


Hi Guylhem,

On Tue, 3 Oct 2006, Guylhem Aznar wrote:

> Hello,
> 
> On 10/3/06, Peter Wippich <pewi@gw-instruments.de> wrote:
> > Depending on your system it is most likely that the HW Uart extension is
> > not realy supported by the serial driver. I currently only know for sure
> > for PXA type system. You need a special HWUART driver to take advantage of
> > the HWUART.
> 
> There are 4 ARM systems I can have access to :
> 
> - A Zaurus 6000, which is a PXA 255 
> - A Zaurus C860, which is also a PXA 255.
This two shall work with a HWUART driver. Make sure the BT Chip is 
connected to the BTUART, which is shared with the HWUART (/dev/ttyS1).  

> - An Acer N30, but it's a s3c2410, which is quite different.
Don't have an s3c2410 system anymore.... 

> - A Simpad - however it is a SA 1100, which has no HWUART. Moreover,
Never used this one .... 
 
> Yes please. I would make a great base for the article.

Ok, but be warned. It will not run out of the box and is only tested with 
2.6.14 kernel. I've attached the driver source and a modified Kconfig and 
Makefile. This will go to linux/drivers/bluetooth/ . You also have to edit 
the Kconfig to get the driver enabled for your machine type. 

Than you have to set up a platform device for the HWUART and disable the 
standard UART driver (to avoid conflicts). This must be somewhere within 
/linux/arch/arm/mach-pxa/ 

Where exactly depends on your machine type. For the standard kernel I 
think it is within generic.c. Look for something like 

static struct platform_device btuart_device = {
        .name           = "pxa2xx-uart",
        .id             = 1,
};

And replace this with 

#if defined(CONFIG_ROAD_S101_BTHWUART) || defined(CONFIG_ROAD_S101_BTHWUART_MODULE) 
//-----------------------------------------------------------------------------
// HW Uart for Bluetooth 
//-----------------------------------------------------------------------------
static struct platform_device hwuart_device = {
    .name   =           "road_btuart", 
    .id     =           -1 ,
} ;
#else
static struct platform_device btuart_device = {
        .name           = "pxa2xx-uart",
        .id             = 1,
};
#endif 

Finaly you need to make sure the driver gets initialized. 
Within the platform device structure

( static struct platform_device *platform_devices[] __initdata = ) 

look for btuart_device and replace it with
 
#if defined(CONFIG_ROAD_S101_BTHWUART) || defined(CONFIG_ROAD_S101_BTHWUART_MODULE)
        &hwuart_device,
#else
        &btuart_device,
#endif 

Further the driver itself defines a function bt_enable(..) which is 
hardware dependend. As a first attempt you may simply comment out 
everything in this function. The driver also assumes a fixed baud rate of 
921600. There is a command line switch to use 115200, but it will not 
switch to higher baud rates (115200 is fairly standard, so this may help 
testing). To get the higher baud rate you have to change the standard baud 
rate of your bluetooth module. If it is CSR based you can use the pstools 
supplied with the bluez utils. 

Good luck ! 

Peter 

|       Peter Wippich                   Voice: +49 30 46776411          |
|       G&W Instruments GmbH            fax:   +49 30 46776419          |
|       Gustav-Meyer-Allee 25, Geb. 12  Email: pewi@gw-instruments.de   |
|       D-13355 Berlin  / Germany                                       |

---1463794332-1640826198-1159889625=:5319
Content-Type: APPLICATION/x-gtar; name=road_btuart.tgz
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.63.0610031733450.5319@redbean.intranet.gw-instruments.de>
Content-Description: 
Content-Disposition: attachment; filename=road_btuart.tgz

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
SUEW1EcS8w0P9Il3h0akwfdUJSiO+pIAifhQIlDpKwoCS9FbZLxiYCWFBxYc
UEJi9837wn4Sv5YOZaIiD3FhHdF2ANTiAyUnxE4Yq+F7YW9ra7Jf2B/8l95r
nrVPOm1MnvDr2flZB8SVaszjiTvdX4obnPilGu86t0GpVj9qNPZaXE+4qKYC
ZBRDJUjhxQiWmkFOJ3WpIu9zYBctLKAZ3blIegwFiWBaAtnRUkGkEdeoyfPT
K+rxUOsm5nKWrq71MIfK8Z7L/2GEi7/ZMbnvM47dJZ9tbW0V0Zn1wRk2tAu4
ULC6vDK0miWZ/gBpcn4vqwnCWymrKVIOj7A/KLqDqND0fxkpJ0vpAz2RstJq
QZXu2fmo3+qo+b/on0yooydFi1pavmD0NR1hUu3L9MgGXa9nfuhxVIiJi90E
cJDL6Pc5rjgEzzRZEhcGXv4D/pg627xQm5bHCM1a5PH4g0kXRX6UreInbWKF
C1M9Q+iU+4a8o5GHE+WhBeuu+Pdo5WAYUtTbF1JJMNmY2qE/04quEUUho9iz
Z08Uq5oI3PJ+i0xE1aZY23MXbHTN6AwoklZyKLQIvZvM0V2aL3URaYu34S64
8/vugrQF+Y1LiYaVjGMaq7Mfj1j6TouIbNWI+M3O2Xm78zmukKIzA6zuB5dn
Z7JtKVaf2gZEbGFCT+aAabs+/4NYQGuleAABLD4PSbqyq3ZXTdlVssPYmHJK
OhPZA46pl43kdSH2dGXx8TKNSLALDqxXsOtQzaFSPM4UaPS+qkU9xRSfaBuK
K1rRYGEL0zpgXaQ0lcUoPycirhxRB3lLbaKm9S7liJ4l+JjsbKq2si8UZWDI
aTaN6R8b0S+LMy3fFdSmu6H5JijCxJ251vnpKbjOfGdOqSrM+UQPcs0jxbE/
3pdUsGEp/jRspV1DBRuWoCuxfZWaBP70wqOfeqILlWe4xGdqvUnvOudzc7HU
RB2Gbh7rr0YVbLGIm8mNrMQrB4ZlFx7VqyZyHx/4rHTZ6rGKMBJhMSudVuxz
ImihOOXGbblmYBeizFx4AT2oZS6fGt5NtK6ikf3z1uikddqOKr3vfJuOEk55
M4bkiLutqFVgskEKc0XXJdPlXdF1YMwkrTl3Q0DGp3hN1qK7i74xpVuOZKry
/+/jB2pHF2ncJux4uS30POyMUetFGzWHn/CMELL+y4tR//ikA7KRwPjDD7yF
GYhVtd6vqB2VNSyeHCugi8dcdWWwzpr0pdTkwgMj3Aae+K2lXOfaWq7kyBwy
JWiFvsRlHAr0tHMKbxRvKM94jpg46pGhRNgl2VP8iH48pYyHCpDiMwmIXKwK
gIJTsWRSFxWUgmsxKA2psBQYi2FpSIUlARfDJgExtSlpcQUToiEVnAyvGD8N
HQrpAi/uHVD1BHDU6w91cR1XiZOiEybsgrRACP89q5dFoUwPAPUhvnKmqNlP
vjiJEMTgRWzp9dZSqiCaaGtrxEu8BhXT8KSwRX5LsdoDOtNWcqaUi8T0mAeG
ORPn/ZEHyDsAkeWtONovSU5SJ5nZ9EognWUSFfopqfMNIhAlVSSCBMWThCAq
qszVjGcJ5muSQmZ4/J0d97Pus2dvXlC8oVRYNiqpnceULxNIoZL7RnECFvF7
3XLuwIVOhK9ZuFQGgnbFStk4VFkR96V0/IGZccfTNWhN0FKlX0zgJQwK1oaz
ZB5WlqbrTCzx45A4mszjqvx4BPuS0WQG8WWCOWr0G4vkonM9ydJhungpGccu
LECN/+tDk24Yyfwle7c8hWAI+1ywk9aA/XzWYDXmuPEPpE4MTBkNkzpGEbL/
a+9qe9u4YfDn9FdoA9rFq7s0LQYMLdzBjW00gNMUtrPu28GeL64xO8780qRD
8t/Hh6J01N3ZsZsUxQARSGDn7niiRJHUI1J59xH31vBE8rHdfW5u3MdDzVaS
TYzLUm+c1KsqFS7jhjTkGi39ZMjyz6Pv6qvlbNBfDVmy406jblppn0YnVWzq
b4WNY9v1bENJ4ZuRoPOT7ag+8TadXtccmCP67fmdsJCuluiGP+E2X/tjhCsa
dz6ZXclI8HGRnl8VMIQ55UooI5xbR65lm4g4I5lwQeH/edYq+yz9To577eTl
C2oYvvQ6kKjpWDLy18KzF1XTm49HI7IanT/pyZcvqsAO8MExDXvHDf2Eh54R
MqnP4AHgWg55kCaTVNbUpJijwpOtlq9709nz9oZiSdtro5TrxmpXo11/e3cv
2UyxXMNFZ32/NdptwOj08idcXtdqhYxRhRQwwIDqBHOweIfVnuPRakHeN2/M
b1l5VMji03j0KccDwiHlfjvp1CxYK54dvQOcjoljMn2lWjDXcMok1IgWvazz
g/7CVlOdj0crW63GblWZOAuwJbxzslhSmLvGzuXtkLNhRbN1WBFp/SNXfRSt
zrDYotgWR0XzIu8qNSMKlzHxR/35oD9KrTfHxGUj1z/nHHle0HLJHc429W8c
a2synGXeL9x4Ga6m0y+8XeVvsPtaOkO00cnglRD05MdrfrteXxo/fVqaJzld
TNL0cv9Xn1VwW/pCb7E0rvrKp39gJwYCLFw3wFVauNio4WgGbgGD3rkOgHg3
36z5RQ3I2RnsHD51esen/nO76z/W/0CZiDKQN9ZCnp71Xtw9UUcTMuKTnMMK
PEIZ9rRDadzG2OAbee/MUQ8muROIyz33I9V9MAXF/su6aqh8YHl/6TEs8yjE
CxCSeorsQNVOUZ/u7jnpYEHVZ1U840BgF2Lovt3NbLiBZpV/+NAS+akNOxa2
Xt5uITPGT9celMIwNklwkoJbG1zOZwMPkTrlWAcoW13WASyNXLlJYL5qKSQj
dDRP4aWRF8qsMljAcmTU8u+pzVRdjP9NZ+fhdKrYZFWsRJrtTdhlHguw9s5B
Zot0KdnLz6um9D0OJstmJfVaYVOHbwmKXsL7ZI/DCbdttu+6LN+1SSD2gqtp
zuYbx/BfXIn6s0O7n+bmFMqppb2eQToFRqhDUw+4HB+cUrcuZqs5TsKD3Q6M
tp+l9CdqAs7lw3YBzbd93u+SYDuf5FA13XrSfUe3VHXlNIpvP7tkIwrn6GbJ
ucvGOFQ5aSeXtcz/Mef98YRdEjsgPJ45Pi56EjTT5FXG6rTSFyuPhufUfiuU
j9umduZVu17xXtK2jTHlrdGNQbrFIky3sKmBlcL2CA9IOYo6T6ezz4V5b+6Y
+GuSPYoGACEBXhDuoVkRA5RDGm4VbZiDR7z5Zgggr0eMU2T6YY1HJachpb3F
Oymqp4vacFv0AehHqVySw7s+nJiyrpVKblNiVKvmcppMKTqmuDGRM1HI4dF6
Z4KzhDYECU7QnUbFT0gPLayfP69cBTqvseUYO+Il++N74ebdrVd9bji2Rrtn
3Q/N942kcdytAyN2r9rLOlF3bQAuSFTNtomPWphd4J9HXMyW9jq9KDjdQdwF
PH1guXwIQ9yZj8ssGc44ll9ySD5e2D31hZmvLi7GnFaQdZThPc78zqaz58H2
ZkHbSvtT5rwdYZ3btGXAp21CoeRJ/o7YhyJPs7yuSvLEcraiqYSKSmJCwqOP
cV4JQh/sOi6vsTShb6tp5g+8wghPSR0CVMD/2UWisgUDE4wrCJ6gGYThYwhL
5ITfLSKTRvHKDIt/RJ6MxvMvWqHRKgK1SBjwQcp5NLTENQBb9BroCpdYx3jV
BkNFvk1UHirnNkrAf4pNFOY/SP/q40hZCDS2yEcgtl4vqQWTLKyURxUxdPys
QmA2ftIY/CMJGoHPqY2JHYYTlJWfHAUIlf1juG56HY5raV/qAkWSH7MxO7wm
FNH8UFKouIWgLAOCBkTpWZDOSMGeR55emz31jEWZQu3KYXKgTcuCjJTlYrin
dLbCMkAJxDRY8ycCrS7z1iaEoD1MeFvucnmulbqFb+sD1iPNm+yXtHc7d1D0
B51m9+ykmTTfszcIl1O4+fsbby39Hq2oy6R/PDRve8331L/ajFeNqlTGAU4b
apUr5ndzSNHp83Bi7GD89WTaBlFXM6IEVRdGuyLrdu7dja4H7MvgbAaerVWD
KT1tteRfHV2ZMsvmQO51CM4akLsU3rZ8vx7i1s8/PMwd9NwOULeo/k5wN2gb
yDsb9YeGvS3ne0Pfjs194e9M0AeGwPXQbol72rZ8JfYp2pAZwruqpg0ZwlxB
u5rKHkrd91ig324q87FbQKksN818BxmA7hUX3hqHOxS8uljxh3LqfGiaOnot
t+LjhWXhqrTBXXUndj3KHRRmnWwip8bKs/KthnyYX4CKQM1t8U1FYyV0dbBa
0MUnl6SBZC6mCX23GV90jcG4DMLgr/i7XaRnF+x3XHEi1XIy2qdYoFooYPUR
8tYOfn52X9oIVzJY5Y6K2isccfejdNjjRZV+2GEHkFJ4xGklC2TkLpfGsP8k
GACbjCYnznETVHMquZPckiS9HqtkjrR/QTrm2yxvylImNr0LnPZDTnT9ex+H
HClSpEiRIkWKFClSpEiRIkWKFClSpEiRIkWKFClSpEiRIkWKFClSpEiRIv0v
6D+0GvWSAKAAAA==

---1463794332-1640826198-1159889625=:5319
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
---1463794332-1640826198-1159889625=:5319
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

---1463794332-1640826198-1159889625=:5319--
