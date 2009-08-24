Return-Path: <cyrus@holtmann.org>
Message-ID: <FC8DB2E521304A449D5398632C2186C8@TSESUO>
From: "Abraham J. Velez \(EndoraSoft\)" <ajvelez@endorasoft.es>
To: <linux-bluetooth@vger.kernel.org>
References: <9DEA418B8D574156A6FD8FE5923922EF@TSESUO> <4A906110.8050200@dtsp.co.nz>
Subject: Re: Fw: Question about the connect Function and BlueZ.
Date: Mon, 24 Aug 2009 19:19:05 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

The errno works but if the socket is NON-Blocking always is 115 
(EINPROGRESS).

We need to know if the user has cancel the connexion or the connexion has 
broken by timeout.

We used the OBEX Push connexion and the terminal show confirmation to accept 
connexion.

In this case are three possible options:

-1º The user accept  the connexion (says YES to the question of terminal) 
(no problem the connexion is active).
-2º The user cancel te connexion (says NO to the question of terminal).
-3º The question is cancel automatic (more than 30 seconds in the screen).

If we use connect non-blocking ....

How can we distinguish between these two last cases (2 or 3)?
(errno always is 115 (EINPROGRESS) if is a timeour or if the user says NO)

Thanks in avanced,

Regards,
Abraham.


----- Original Message ----- 
From: "David Sainty" <david.sainty@dtsp.co.nz>
To: "Abraham J. Velez (EndoraSoft)" <ajvelez@endorasoft.es>
Cc: <linux-bluetooth@vger.kernel.org>
Sent: Saturday, August 22, 2009 11:20 PM
Subject: Re: Fw: Question about the connect Function and BlueZ.


> Abraham J. Velez (EndoraSoft) wrote:
>>> the problem seems similar or the same to what Nick posted a view weeks
>>> ago. If you use blocking connect() in one thread the close() in another
>>> thread will not terminate the connection attempt. As far as I can tell
>>> this is true and should be fixed. It however works fine if you just
>>> would use proper non-blocking connect() with a mainloop.
>>
>> The problem of this method is the control of errors. The call to connect
>> function is blocking (because we need to
>> know if the user of the terminal can not connect errno==ECONNREFUSED).
>
> Does this not work?  From connect(2):
>
>       EINPROGRESS
>              The  socket  is  non-blocking  and the connection cannot
> be com-
>              pleted immediately.  It is possible to select(2) or
> poll(2)  for
>              completion  by selecting the socket for writing. After
> select(2)
>              indicates writability, use getsockopt(2) to  read  the
> SO_ERROR
>              option  at  level SOL_SOCKET to determine whether
> connect() com-
>              pleted  successfully  (SO_ERROR  is  zero)   or
> unsuccessfully
>              (SO_ERROR  is one of the usual error codes listed here,
> explain-
>              ing the reason for the failure).
>
>


--------------------------------------------------------------------------------



No virus found in this incoming message.
Checked by AVG - www.avg.com
Version: 8.5.392 / Virus Database: 270.13.64/2319 - Release Date: 08/22/09 
06:06:00


