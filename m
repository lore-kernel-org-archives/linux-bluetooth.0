Return-Path: <cyrus@holtmann.org>
Message-ID: <4A9303F2.1090709@dtsp.co.nz>
Date: Tue, 25 Aug 2009 09:19:46 +1200
From: David Sainty <david.sainty@dtsp.co.nz>
MIME-Version: 1.0
To: "Abraham J. Velez (EndoraSoft)" <ajvelez@endorasoft.es>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: Fw: Question about the connect Function and BlueZ.
References: <9DEA418B8D574156A6FD8FE5923922EF@TSESUO> <4A906110.8050200@dtsp.co.nz> <FC8DB2E521304A449D5398632C2186C8@TSESUO>
In-Reply-To: <FC8DB2E521304A449D5398632C2186C8@TSESUO>
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Abraham J. Velez (EndoraSoft) wrote:
> Hi,
>
> The errno works but if the socket is NON-Blocking always is 115 
> (EINPROGRESS).
>
> We need to know if the user has cancel the connexion or the connexion 
> has broken by timeout.
>

Did you read what I sent?  Especially the references to using poll() and 
getsockopt()?

It sounds like your problem is solved by getting the final error code 
from connect() non-blocking?  And that's how you do it.

>>
>> Does this not work?  From connect(2):
>>
>>       EINPROGRESS
>>              The  socket  is  non-blocking  and the connection cannot
>> be com-
>>              pleted immediately.  It is possible to select(2) or
>> poll(2)  for
>>              completion  by selecting the socket for writing. After
>> select(2)
>>              indicates writability, use getsockopt(2) to  read  the
>> SO_ERROR
>>              option  at  level SOL_SOCKET to determine whether
>> connect() com-
>>              pleted  successfully  (SO_ERROR  is  zero)   or
>> unsuccessfully
>>              (SO_ERROR  is one of the usual error codes listed here,
>> explain-
>>              ing the reason for the failure).
>>
>>

