Return-Path: <skrzypek-piotr@o2.pl>
From: skrzypek-piotr@o2.pl
To: =?iso-8859-2?Q?Marcel_Holtmann?= <marcel@holtmann.org>
Cc: bluez-users@lists.sourceforge.net
Subject: =?iso-8859-2?Q?Re:_[Bluez-users]_NAT_connection_established_but_n?=
	=?iso-8859-2?Q?o_data_transport?=
Date: Tue,  2 Nov 2004 08:41:27 +0100
Content-Type: text/plain; charset="iso-8859-2";
In-Reply-To: <1099362451.10948.22.camel@pegasus>
References: <20041101214200.C1E5BD0B0C@rekin6.o2.pl>  <1099347952.10948.19.camel@pegasus>  <20041101235513.2017B3816E@rekin11.go2.pl>
	<1099362451.10948.22.camel@pegasus>
Message-Id: <20041102074127.9B9CAD0B0F@rekin6.o2.pl>
List-ID: <bluez-users.lists.sourceforge.net>

>Hi Pete,
>
>there is a "Reply to All" button in your mail client ;)
>
>> >try to activate bnep0 and set an IP address.
>> i set: ifconfig bnep0 192.168.0.1
>> and when i type ifconfig there is nothing about bnep0, but when i
type
>> ifconfig bnep0
>> i can see everything just like it should be: the same mac adress
>> (read from cover of usb device), ip 192.168.0.1, appropriate mask
>> etc. but still it doesn`t send/recieve data. 
>> 
>> Maybe it can help somehow:
>> I checked the transmission status on the notebook and it says that
>> the device is transmitting (especially while pinging) but not
reciving.
>
>are you sure that you are using the latest -mh patch for your kernel?

There is only one patch for kernel 2.4.27 and i`m using it.

>Regards
>
>Marcel
>
