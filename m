Return-Path: <albert.ribas@estudiants.urv.es>
Date: Fri, 30 Apr 2004 11:39:54 +0200
From: ALBERT RIBAS GUASCH <albert.ribas@estudiants.urv.es>
Subject: Re: [Bluez-users] PAN
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Message-id: <11004610b856.10b856110046@estudiants.urv.es>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_QTFnDHpyd1nq1bW8Cnfvfg)"
List-ID: <bluez-users.lists.sourceforge.net>

This is a multi-part message in MIME format.

--Boundary_(ID_QTFnDHpyd1nq1bW8Cnfvfg)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline

Hi Marcel,

If I do an hciconfig -a, i get the following info:

hci0:
Type: USB
	BD Address: 00:0A:3A:50:14:BC ACL MTU: 192:8  SCO
MTU: 64:8
	UP RUNNING PSCAN ISCAN 
	RX bytes:3963 acl:82 sco:0 events:60 errors:0
	TX bytes:3210 acl:37 sco:0 commands:19 errors:0
	Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
	Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 
	Link policy: RSWITCH HOLD SNIFF PARK 
	Link mode: SLAVE ACCEPT 
	Name: 'BlueZ (0)'
	Class: 0x000100
	Service Classes: Unspecified
	Device Class: Computer, Uncategorized
	HCI Ver: 1.1 (0x1) HCI Rev: 0x20d LMP Ver: 1.1 (0x1)
LMP Subver: 0x20d
	Manufacturer: Cambridge Silicon Radio (10)

I don't get any errors on calling dmesg, but I have
DHCP running in eth0 , does this have any influence
on the bluetooth connection?

Now, I've managed to assign IP to bnep0 in both
machines,and when everything is stable, I can ping
from one machine to the other, but I've checked that
sometimes bnep0 gets down, I can see it with
ifconfig -a, and I can assign the IP again, but how
can I do to mantain bnep0 stable?
It is something very strange because sometimes it
works fine for five minutes, others is just a pair
of minutes, and in one of the tests it's been
working for twenty minutes!

I send you the output on hcidump -w before doing a
pair of pings.

Thank you very much!!!!

Albert


----- Missatge original -----
De: Marcel Holtmann <marcel@holtmann.org>
Data: Dimarts, Abril 27, 2004 1:58 pm
Assumpte: Re: [Bluez-users] PAN

> Hi Albert,
> 
> > I already have two computers to try the PAN on them
> > with two USB dongles,  but I still have some
problems.
> > 
> > In one computer I run:
> > 
> > modprobe bnep
> > hcid
> > pand --listen --role GN
> > 
> > And in the other one:
> > modprobe bnep
> > hcid
> > pand --connect 00:0A:3A:50:20:3C
> > 
> > then, I look at ifconfig (on both sides) and the
> > connection is ok for a while, but when I check
> > ifconfig again it has disappeared!!
> > 
> > Then, If _I do a pand --show on the client side, I
> > see nothing, but on the master side, it is shown as
> > if the connection was still ok!
> > 
> > Could you help me to mantain stable this
connection??
> 
> try to use "ifconfig -a" so you also see
unconfigured interfaces. 
> Do you
> have somekind of DHCP running? What Bluetoth chip
is on the Belkin
> dongles (check with "hciconfig -a")? Run "hcidump
-w <file>" as 
> root on
> one machine and send us the binary dump file. Do
you see any errors 
> whencalling dmesg?
> 
> Regards
> 
> Marcel
> 
> 
> 

--Boundary_(ID_QTFnDHpyd1nq1bW8Cnfvfg)
Content-type: application/octet-stream; NAME=file
Content-transfer-encoding: base64
Content-disposition: attachment; filename=file

ZgAAAKIdkkAMiAoAAikgYQBdAEAABAAKOlAgPAgARQAAVAAAQABAATKjAgICAgICAgEIALoN
OQkBAKIdkkDahwoACAkKCwwNDg8QERITFBUWFxgZGhscHR4fICEiIyQlJicoKSorLC0uLzAx
MjM0NTY3CAABAKIdkkAPAQsABBMFASkAAQBgAAEAoh2SQFIgCwACKSBbAFcAQAACCABFAABU
HNAAAEABVdMCAgIBAgICAgAAwg05CQEAoh2SQNqHCgAICQoLDA0ODxAREhMUFRYXGBkaGxwd
Hh8gISIjJCUmJygpKissLS4vMDEyMzQ1NjdmAAAAox2SQMKWCgACKSBhAF0AQAAEAAo6UCA8
CABFAABUAABAAEABMqMCAgICAgICAQgA7f45CQIAox2SQKSWCgAICQoLDA0ODxAREhMUFRYX
GBkaGxwdHh8gISIjJCUmJygpKissLS4vMDEyMzQ1NjcIAAEAox2SQHvRCgAEEwUBKQABAGAA
AQCjHZJA8ugKAAIpIFsAVwBAAAIIAEUAAFQc0QAAQAFV0gICAgECAgICAAD1/jkJAgCjHZJA
pJYKAAgJCgsMDQ4PEBESExQVFhcYGRobHB0eHyAhIiMkJSYnKCkqKywtLi8wMTIzNDU2N2YA
AACkHZJA2L0KAAIpIGEAXQBAAAQACjpQIDwIAEUAAFQAAEAAQAEyowICAgICAgIBCADU1zkJ
AwCkHZJAu70KAAgJCgsMDQ4PEBESExQVFhcYGRobHB0eHyAhIiMkJSYnKCkqKywtLi8wMTIz
NDU2NwgAAQCkHZJAdQcLAAQTBQEpAAEAYAABAKQdkkDnHgsAAikgWwBXAEAAAggARQAAVBzS
AABAAVXRAgICAQICAgIAANzXOQkDAKQdkkC7vQoACAkKCwwNDg8QERITFBUWFxgZGhscHR4f
ICEiIyQlJicoKSorLC0uLzAxMjM0NTY3ZgAAAKUdkkDh5AoAAikgYQBdAEAABAAKOlAgPAgA
RQAAVAAAQABAATKjAgICAgICAgEIAMmwOQkEAKUdkkDE5AoACAkKCwwNDg8QERITFBUWFxgZ
GhscHR4fICEiIyQlJicoKSorLC0uLzAxMjM0NTY3CAABAKUdkkBuPQsABBMFASkAAQBgAAEA
pR2SQN1UCwACKSBbAFcAQAACCABFAABUHNMAAEABVdACAgIBAgICAgAA0bA5CQQApR2SQMTk
CgAICQoLDA0ODxAREhMUFRYXGBkaGxwdHh8gISIjJCUmJygpKissLS4vMDEyMzQ1NjdmAAAA
ph2SQPILCwACKSBhAF0AQAAEAAo6UCA8CABFAABUAABAAEABMqMCAgICAgICAQgAtok5CQUA
ph2SQNULCwAICQoLDA0ODxAREhMUFRYXGBkaGxwdHh8gISIjJCUmJygpKissLS4vMDEyMzQ1
NjcIAAEAph2SQHlvCwAEEwUBKQABAGAAAQCmHZJA74YLAAIpIFsAVwBAAAIIAEUAAFQc1AAA
QAFVzwICAgECAgICAAC+iTkJBQCmHZJA1QsLAAgJCgsMDQ4PEBESExQVFhcYGRobHB0eHyAh
IiMkJSYnKCkqKywtLi8wMTIzNDU2NygAAQCnHZJA/jsLAAIpICMAHwBAAAIIBgABCAAGBAAB
AAo6UCA8AgICAQAAAAAAAAICAgIuAAAApx2SQCs8CwACKSApACUAQAAEAAo6UCA8CAYAAQgA
BgQAAgAKOlAUvAICAgIACjpQIDwCAgIBCAABAKcdkkBYqQsABBMFASkAAQBgAAEArR2SQGUg
AAACKSBbAFcAQAACCABFAABUAABAAEABMqMCAgIBAgICAggA9vW8KQEALCCSQJN8BwAICQoL
DA0ODxAREhMUFRYXGBkaGxwdHh8gISIjJCUmJygpKissLS4vMDEyMzQ1NjdmAAAArR2SQKcg
AAACKSBhAF0AQAAEAAo6UCA8CABFAABUWLIAAEABGfECAgICAgICAQAA/vW8KQEALCCSQJN8
BwAICQoLDA0ODxAREhMUFRYXGBkaGxwdHh8gISIjJCUmJygpKissLS4vMDEyMzQ1NjcIAAEA
rR2SQNaJAAAEEwUBKQABAGAAAQCuHZJAkU4AAAIpIFsAVwBAAAIIAEUAAFQAAEAAQAEyowIC
AgECAgICCAAfyLwpAgAtIJJAaKoHAAgJCgsMDQ4PEBESExQVFhcYGRobHB0eHyAhIiMkJSYn
KCkqKywtLi8wMTIzNDU2N2YAAACuHZJAx04AAAIpIGEAXQBAAAQACjpQIDwIAEUAAFRYswAA
QAEZ8AICAgICAgIBAAAnyLwpAgAtIJJAaKoHAAgJCgsMDQ4PEBESExQVFhcYGRobHB0eHyAh
IiMkJSYnKCkqKywtLi8wMTIzNDU2NwgAAQCuHZJALrAAAAQTBQEpAAEAYAABAK8dkkAsaQAA
AikgWwBXAEAAAggARQAAVAAAQABAATKjAgICAQICAgIIAA+hvCkDAC4gkkB20QcACAkKCwwN
Dg8QERITFBUWFxgZGhscHR4fICEiIyQlJicoKSorLC0uLzAxMjM0NTY3ZgAAAK8dkkBUaQAA
AikgYQBdAEAABAAKOlAgPAgARQAAVFi0AABAARnvAgICAgICAgEAABehvCkDAC4gkkB20QcA
CAkKCwwNDg8QERITFBUWFxgZGhscHR4fICEiIyQlJicoKSorLC0uLzAxMjM0NTY3CAABAK8d
kkA+4gAABBMFASkAAQBgAAEAsB2SQDubAAACKSBbAFcAQAACCABFAABUAABAAEABMqMCAgIB
AgICAggA+3m8KQQALyCSQIj4BwAICQoLDA0ODxAREhMUFRYXGBkaGxwdHh8gISIjJCUmJygp
KissLS4vMDEyMzQ1NjdmAAAAsB2SQGybAAACKSBhAF0AQAAEAAo6UCA8CABFAABUWLUAAEAB
Ge4CAgICAgICAQAAA3q8KQQALyCSQIj4BwAICQoLDA0ODxAREhMUFRYXGBkaGxwdHh8gISIj
JCUmJygpKissLS4vMDEyMzQ1NjcIAAEAsB2SQDUYAQAEEwUBKQABAGAAAQCxHZJADK4AAAIp
IFsAVwBAAAIIAEUAAFQAAEAAQAEyowICAgECAgICCADoUrwpBQAwIJJAmR8IAAgJCgsMDQ4P
EBESExQVFhcYGRobHB0eHyAhIiMkJSYnKCkqKywtLi8wMTIzNDU2N2YAAACxHZJAOq4AAAIp
IGEAXQBAAAQACjpQIDwIAEUAAFRYtgAAQAEZ7QICAgICAgIBAADwUrwpBQAwIJJAmR8IAAgJ
CgsMDQ4PEBESExQVFhcYGRobHB0eHyAhIiMkJSYnKCkqKywtLi8wMTIzNDU2NwgAAQCxHZJA
OiMBAAQTBQEpAAEA

--Boundary_(ID_QTFnDHpyd1nq1bW8Cnfvfg)--
