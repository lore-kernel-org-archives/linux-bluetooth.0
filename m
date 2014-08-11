Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZLEDBFa-wV5L5Pfi-PzA877PxSrktsVLpzCRuQ4nu1eKQ@mail.gmail.com>
References: <CAD81oNZL0qATu_z_TJT8psaMhpmV34w6xmA2+=OKerSE1NSvOw@mail.gmail.com>
	<CABBYNZ+zRKzv4yTc8M2Fi0eN6gC921b9zaey5FKGVq_bJJueBg@mail.gmail.com>
	<CAD81oNbjd3-Y_7C=75TfBP0oXjA3eFWbezsD8nROUrseUJZNhg@mail.gmail.com>
	<CAD81oNZkRk-KFcE1bkj8TWiqe7dyVjHJADicT-f5KEkKtcnbyA@mail.gmail.com>
	<574DE1E1-7A53-4629-88FC-7164EC1880AA@holtmann.org>
	<CAD81oNY41-8DhJCOetLa_TCrPLBeiJFHQJ7TxawydwQ5S_Lmwg@mail.gmail.com>
	<CABBYNZLEDBFa-wV5L5Pfi-PzA877PxSrktsVLpzCRuQ4nu1eKQ@mail.gmail.com>
Date: Mon, 11 Aug 2014 08:07:59 +0200
Message-ID: <CALkxMhFSGzAvmxiKN2Q8KRU1MODfgKHVtoFTxZG1TsUDBCAgmg@mail.gmail.com>
Subject: Re: [A2DP] Incoming connections do not succeed
From: Michal Labedzki <michal.labedzki@tieto.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Artem Rakhov <arakhov@chromium.org>, Marcel Holtmann <marcel@holtmann.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> I could not find anything l2cap related in this logs

See frame 258. It seems to be HFP. However log file seems to be broken
or... btmon and Wireshark have broken support for H1 (direction
[Sent/Recv] seems to be correct in logs, but Channel type is not
[btmon/wireshark treat 0 as ACL, 1 as HCI? little strange...]).

On 10 August 2014 09:32, Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrot=
e:
> Hi Artem,
>
> On Fri, Aug 8, 2014 at 10:32 AM, Artem Rakhov <arakhov@chromium.org> wrot=
e:
>> Hi Marcel,
>>
>> Please find Packet Logger's btsnoop log in the attachment.
>>
>> So far I have 2 observations:
>> 1. Mac does not require any authorization (most likely it's not the caus=
e)
>> 2. I found another BT speaker which works properly. At first, I'm
>> seeing the same behavior: speaker initiates connection, BlueZ sends
>> Configure Request (with no MTU), then speaker disconnects. But after
>> that the device tries to initiate connection for the second time, and
>> this time it is successful: after BlueZ sends Configure Request with
>> no MTU, speaker answers with another Configure Request (with some
>> MTU), and connection is established normally. Is it possible, that
>> BlueZ is doing something wrong, but then this new speaker tries
>> something else, while the old one does not?
>
> I could not find anything l2cap related in this logs, but I notice
> there a LE scanning ongoing perhaps you have should try disabling it
> with Disconnect method for now. Anyway A2DP code is not really
> involved with L2CAP connection setup so we would have to look at the
> kernel changes but I quick check doesn't show anything and you said
> you have tried with 3.10 so Im afraid this is only reproducible with
> some specific device.
>
> Btw, if you want to really isolate the problem you can try to connect
> using avinfo or l2test directly.
>
>
> --
> Luiz Augusto von Dentz
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--=20

Pozdrawiam / Best regards
---------------------------------------------------------------------------=
----------------------------------
Micha=C5=82 =C5=81ab=C4=99dzki, Software Engineer
Tieto Corporation

Product Development Services

http://www.tieto.com / http://www.tieto.pl
---
ASCII: Michal Labedzki
location: Swobodna 1 Street, 50-088 Wroc=C5=82aw, Poland
room: 5.01 (desk next to 5.08)
---
Please note: The information contained in this message may be legally
privileged and confidential and protected from disclosure. If the
reader of this message is not the intended recipient, you are hereby
notified that any unauthorised use, distribution or copying of this
communication is strictly prohibited. If you have received this
communication in error, please notify us immediately by replying to
the message and deleting it from your computer. Thank You.
---
Please consider the environment before printing this e-mail.
---
Tieto Poland sp=C3=B3=C5=82ka z ograniczon=C4=85 odpowiedzialno=C5=9Bci=C4=
=85 z siedzib=C4=85 w
Szczecinie, ul. Malczewskiego 26. Zarejestrowana w S=C4=85dzie Rejonowym
Szczecin-Centrum w Szczecinie, XIII Wydzia=C5=82 Gospodarczy Krajowego
Rejestru S=C4=85dowego pod numerem 0000124858. NIP: 8542085557. REGON:
812023656. Kapita=C5=82 zak=C5=82adowy: 4 271500 PLN
