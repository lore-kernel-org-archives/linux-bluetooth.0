Return-Path: <egrojorge@terra.es>
Date: Sat, 8 May 2004 15:52:53 +0200
From: =?ISO-8859-1?B?Sm9yZ2UgQS4gR29ueuFsZXo=?= <egrojorge@terra.es>
Reply-To: egroJorge <egroJorge@terra.es>
Message-ID: <143918984.20040508155253@terra.es>
To: Marcel Holtmann <marcel@holtmann.org>
CC: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re[2]: [Bluez-devel] uclinux and bluez
In-Reply-To: <1083946524.4420.124.camel@pegasus>
References: <1083853467.28356.18.camel@pancho>
 <1083877519.4420.78.camel@pegasus>  <1083925117.1946.36.camel@pancho>
 <1083946524.4420.124.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <bluez-devel.lists.sourceforge.net>

Marcel escribió:

M> Hi Jorge,

>> Anyway, I am porting bluez for uClinux, by now it is working hcid (with
>> the option -n, as a daemon doesnt work due to the uclinux fork
>> implementation), hciattach (what a minor modification), hciconfig,
>> hcitool and rfcomm (the last one is not proved) and now I am trying to
>> make sdpd and sdptool to work.

M> send your patches to the list. If they don't break the current behaviour
M> I am going to include them.

Thanks: what I did it is not exactly a patch but I will comment it
just in case it is useful.

I noticed that hciattach doesnt seem to work in uclinux: i could never
get a "up" device ("hciconfig hci0 up" always failed). In Linux it works
perfectly. So I compared the behaviour in both system and realised
that in linux hciattach sends a 0x01x03x10x00 and in uclinux not. I
think that the sentence "ioctl(fd, HCIUARTSETPROTO, u->proto)" is
which send that in linux but no in uclinux (although doesnt fail in
uclinux, simply doesnt send nothing). I was able to see it thanks to a
oscilloscope.
I havent study the bluetooth protocols but I tried to send the
0x01x03x10x00 "by hand", opening the ttySx in 115200 baudrate and
writing to it directly (with an auxiliar program I wrote).

I know it is not an elegant method and maybe this will only work with
my hardware configuration. I have no idea of why "ioctl(fd,
HCIUARTSETPROTO, u->proto)" is not working but I suppossed it was
fault of the uclinux system (it has a 2.4.20 linux kernel).

I am not way an expert on this topics, so sorry if I have said any
stupidity and also for my not very fluent english (I am from Spain).

Best regards!

(And I will appreciate any comment)

Jorge
