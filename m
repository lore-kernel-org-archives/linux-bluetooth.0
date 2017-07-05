Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: Re: DBUS API: Retrieve current MTU used by remote device
To: <linux-bluetooth@vger.kernel.org>
References: <0fef8015e74a2a96af45c36e9c67dc36@labapart.com>
From: Felix Schulthess <felix.schulthess@scs.ch>
Message-ID: <c9a595e3-b09b-04ae-7040-d85aba5ec2ea@scs.ch>
Date: Wed, 5 Jul 2017 09:44:35 +0200
MIME-Version: 1.0
In-Reply-To: <0fef8015e74a2a96af45c36e9c67dc36@labapart.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Dear all, dear Oliver,

On 05.07.2017 00:45, Olivier MARTIN wrote:

> I looked into the Bluez DBUS API documentation but I have not found
> a way to retrieve the MTU size used for the connection between
> Bluez and a Bluetooth device.

I am also trying to solve this Problem. Cf. my mail earlier on this
list. I suppose that you, Oliver, did not receive it, so I quote:

> I am trying to figure out the MTU of a BLE connection while it is 
> active. If I understand the Core Specification correctly, this can 
> be accomplished with the "Exchange MTU Request" as specified in
> Vol. 3, Part F, Section 3.4.2.
> 
> 1. I know one can send HCI commands with the hcitool. Is it also 
> possible to issue the request specified above using any of the 
> existing hciconfig, hcitool, hciXXX tools to find the MTU?
> 
> 2. There is a connection of which I know that its MTU is 512.
> Still, running 'hciconfig hci0 dev' reports 'ACL MTU: 310:10'. Why
> is that so?

If you figure out how to determine the MTU, I would definitely be
interested. Keep me (i.e. the list) posted.

Best, Felix
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE1nG8hohXK+pQzdzfeVlSCSL32xIFAllcmOMACgkQeVlSCSL3
2xI4dA/+PNrN3gZRe4eC2ufPPlYlQmqI/PymTZzUG9PCeFyA48kKFpnyjkTEccnQ
yuFkgeY4Yin3yxAtXuTNVv8zNpD74jg7s6TzQddKwevDV58KjbhiI1wDzVMTVmKE
L7tEr0MDJmHVXhSiF3teiu6ucC1lMSzoSww8/6j/FQVHbzZ5IAoYGx3QxDWRBw3P
BLxG8FQOqcpx8yC31q1LCEJ1RGtPkV9IN/uCbO4lfNyx3A9CEHI9ZNXuIgwxAChh
6n1Yik7JE7bE84G2ayaGYKQiOZGaCsnPTJINpFpIYGr1Pncy001IFgW4EoWKgCez
XHyB/ILIJVEHQ/vV/RA9VhEPuvnCFl05Lk2LdOz7NYTIdpeZUuNSm5ZGedmjA0bu
9Ip+h6I30aUY62uCq2ilnar/cbkaBL4WTbUucUrhG6AgUcVCahNB/M701xeAvp+e
Jj5dhNUDerG29uSwCWJpWVTYSvBHp/ZCu9/XKI84xCX42hbL2+Ucc3zYAJT5DLAu
QM172bxkr/kOoXJRy1z7i6nEU84dwODirgMROhZICGZRWE+stWxWs0GraMaFsapU
GK4X3T/cQLfnSZffENK8her9+aOxxZIQ0W8C6IYOuPTHw+8TxfIb1lC1xro1wg8I
Dn6ImMjVXznM/EIc56sEIM8ueZOfarxQPUSjOiYjH8zyA5YNTJA=
=6SAE
-----END PGP SIGNATURE-----
