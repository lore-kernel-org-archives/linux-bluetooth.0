Return-Path: <Jan.Sykora@fel.cvut.cz>
Message-ID: <40F65E84.3020104@fel.cvut.cz>
Date: Thu, 15 Jul 2004 12:37:56 +0200
From: Jan Sykora <Jan.Sykora@fel.cvut.cz>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: bluez-users@lists.sourceforge.net, jan.sykora@fel.cvut.cz
Subject: Re: [Bluez-users] Unknown HCI packet type / 3CRWB6096B
References: <40F3BD15.30908@fel.cvut.cz> <1089826519.4517.7.camel@pegasus>
In-Reply-To: <1089826519.4517.7.camel@pegasus>
Content-Type: text/plain; charset=us-ascii; format=flowed
List-ID: <bluez-users.lists.sourceforge.net>

Hi Marcel

Unfortunately it did not help. I have now

kppp with CRTSCTS flow control and

hciattach /dev/ttyS17 any 115200 flow

and I am getting the same error messages.

Do you have any other hints? Thanks.

regards

Jan

Marcel Holtmann wrote:
> Hi Jan,
> 
> 
>>I am able to establish kppp session to siemens s55 mobile and the 
>>connection works OK, however after a while I get messages in 
>>/var/log/messages
>>
>>Jul 12 23:59:26 merlin kernel: h4_check_data_len: Data length is too large
>>Jul 12 23:59:26 merlin kernel: h4_recv: Unknown HCI packet type 00
>>Jul 12 23:59:26 merlin kernel: h4_recv: Unknown HCI packet type c3
......
>>Jul 12 23:59:26 merlin kernel: h4_recv: Unknown HCI packet type ac
>>Jul 12 23:59:26 merlin kernel: h4_recv: Unknown HCI packet type 18
>>Jul 12 23:59:26 merlin kernel: h4_recv: Unknown HCI packet type 27
>>Jul 12 23:59:26 merlin kernel: h4_recv: Unknown HCI packet type f4
>>Jul 12 23:59:26 merlin kernel: h4_recv: Unknown HCI packet type 00
>>Jul 12 23:59:26 merlin kernel: l2cap_recv_acldata: Fragment is too large 
>>(len 17, expect 16)
>>Jul 12 23:59:26 merlin kernel: l2cap_recv_acldata: Unexpected 
>>continuation frame (len 17)
>>Jul 12 23:59:26 merlin last message repeated 8 times
>>Jul 12 23:59:26 merlin kernel: l2cap_recv_acldata: Unexpected 
>>continuation frame (len 15)
>>Jul 12 23:59:31 merlin kernel: h4_check_data_len: Data length is too large
>>.......
> 
> 
> this is an out of sync H4 stream. This happens sometimes. Try to enable
> flow control on your serial port.
> 
> Regards
> 
> Marcel
> 

-- 
Jan Sykora

Czech Technical University in Prague
Faculty of Electrical Engineering
K13137 Department of Radioelectronics
Technicka 2
166 27 Praha 6
Czech Republic

E-mail: Jan.Sykora@fel.cvut.cz
http://radio.feld.cvut.cz/~sykora/
tel: +420 224 35 3921
fax: +420 224 35 5829
