Return-Path: <cyrus@holtmann.org>
Reply-To: <wyrles@ytram.com>
From: "Tom Allebrandi" <wyrles@ytram.com>
To: "'Steffen Becker'" <steffen.becker@tu-ilmenau.de>,
	<linux-bluetooth@vger.kernel.org>
References: <4F7349EC.8080706@tu-ilmenau.de>
In-Reply-To: <4F7349EC.8080706@tu-ilmenau.de>
Subject: RE: problem with using BPA500
Date: Mon, 2 Apr 2012 12:11:21 -0700
Message-ID: <093a01cd1104$69615420$3c23fc60$@ytram.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

> -----Original Message-----
> Hello,
> 
> i have a problem with sniffing my 2 bluetooth devices. Google & forums
> didn't helped me.
> I use the BPA500 for sniffing two BT3.0 devices; maybe someone of you also
> use this. This is my problem:
> The frontline technical support told me, that i have to put my devices in
> discovery mode & at least one device in ssp debug mode. And it is
important
> that the devices get paired AFTER i click on "Start Sniffing".
> I did so, but in my LMP there is some Opcode missing. There is only:
> ...
> au_rand
> sres
> encrypt_mode_req
> 
> But there SHOULD be something like that:
> ...
> comb_key
> au_rand
> sres
> au_rand
> sres
> setup_complete
> encrypt_mode_req
> 
> I think there is no problem with the BPA software, because when i sniff
> BT2.0 devices, everything works fine (because i don't have to use a ssp
> debug mode). And the BPA-support says, there are two possible misstakes:
> either the devices are paired before sniffing, or no device is in sspdebug
> mode. But i think i did this right.
> 
> Maybe you find out what i did wrong:
> 
> - two gentoo-PCs with two BT3.0 Dongles and i installed the latest bluez &
> the patch "Adding SSP debug mode configuration to hciconfig" on both PCs
> PC2 # hciconfig hci0 piscan
> PC1 # hciconfig hci0 piscan
> PC1 # hciconfig hci0 sspdebug 1
> (in a 2nd try also: PC2 # hciconfig hci0 sspdebug 1) click on "start
sniffing" at
> the software
> PC2 # rfcomm listen 0 1
> PC1 # rfcomm -r connect 0 <bluetooth-adress> 1
> 
> The connection worked (as seen on the two conncted PCs) but the sniffing
> software didn't really captured it. The Icon is blue indeed (so it's
> synchronized), but somehow there is missing something, because it doesn't
> sniff correctly.
> 
> Hope someone of you can help me.
> 
> Regards,
> Steffen

Hi!

If you don't get two sets of 

-> au_rand
<- sres
<- au_rand
-> sres

then no pairing occurred. Mutual LMP authentication (au_rand/sres in each
direction) is only used during pairing.

(A) For traditional pin code based pairing you should see

-> in_rand
-> comb_key
<- comb_key

 (B) For SSP based pairing, you should see

-> io_capability_req
<- io_capability_res
<-> some other SSP related messages based on the I/O capabilities
-> dhkey_check
<- accepted
<- dhkey_check
-> accepted

You should always see sequence (A) or (B) if pairing takes place. Neither of
these have anything to do with SSP Debug Mode.


So, given what you are seeing, I agree with Frontline tech support, no
pairing is taking place.

You might want to run HCIdump and look at the HCI sequence.

<- link_key_request
-> link_key_request_reply

Means the devices are already paired

<- link_key_request
-> link_key_request_negative_reply

Means the devices are not already paired

----------

Secure Simple Pairing uses the Diffie-Hellman Elliptic Curve algorithm
(DHEC).

DHEC as used in Bluetooth is based on private secrets (keys) that are only
known to each controller. You cannot set the private key nor can you read it
out of the controller. Most controllers make one up as needed.

The private keys are never on the air:  values derived from the keys  -- the
"public keys" -- are exchanged between the devices.

The "magic" of DHEC is that if you know

	Private Key A		Private Key B
	Public Key A		Public Key A
	Public Key B		Public Key B

you can feed those triplets into a formula that will produce the same
answer.

Since the private keys cannot be known, that pretty much makes air sniffing
useless.... UNLESS you enable SSP Debug Mode.

In SSP Debug Mode a set of well known keys is used.

If device A is in SSP debug mode

	Debug Mode Private Key A	Private Key B
	Debug Mode Public Key A	Debug Mode Public Key A
	Public Key B			Public Key B

Feeding those triplets into the formula that will produce the same answer.

Similarly, if device B is in SSP debug mode

	Private Key A			Debug Mode Private Key B
	Public Key A			Public Key A
	Debug Mode Public Key B	Debug Mode Public Key B

Feeding those triplets into the formula that will produce the same answer.

The trick is that when the air sniffer sees either of the debug mode public
keys on the air, it automatically knows the corresponding debug mode private
key for that device. That gives the air sniffer one (or both) of the
triplets that are used by the devices allowing it  (the air sniffer) to
compute the same answer.

----------

So in short, the air sniffer should always see the exchanges that I listed
in the first section of my answer. SSP debug mode lets the air sniffer do
something useful with the data that it collected.

Cheers!

--- tom


