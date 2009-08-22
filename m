Return-Path: <cyrus@holtmann.org>
Message-ID: <4A906110.8050200@dtsp.co.nz>
Date: Sun, 23 Aug 2009 09:20:16 +1200
From: David Sainty <david.sainty@dtsp.co.nz>
MIME-Version: 1.0
To: "Abraham J. Velez (EndoraSoft)" <ajvelez@endorasoft.es>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: Fw: Question about the connect Function and BlueZ.
References: <9DEA418B8D574156A6FD8FE5923922EF@TSESUO>
In-Reply-To: <9DEA418B8D574156A6FD8FE5923922EF@TSESUO>
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Abraham J. Velez (EndoraSoft) wrote:
>> the problem seems similar or the same to what Nick posted a view weeks
>> ago. If you use blocking connect() in one thread the close() in another
>> thread will not terminate the connection attempt. As far as I can tell
>> this is true and should be fixed. It however works fine if you just
>> would use proper non-blocking connect() with a mainloop.
>
> The problem of this method is the control of errors. The call to connect
> function is blocking (because we need to
> know if the user of the terminal can not connect errno==ECONNREFUSED).

Does this not work?  From connect(2):

       EINPROGRESS
              The  socket  is  non-blocking  and the connection cannot 
be com-
              pleted immediately.  It is possible to select(2) or 
poll(2)  for
              completion  by selecting the socket for writing. After 
select(2)
              indicates writability, use getsockopt(2) to  read  the  
SO_ERROR
              option  at  level SOL_SOCKET to determine whether 
connect() com-
              pleted  successfully  (SO_ERROR  is  zero)   or   
unsuccessfully
              (SO_ERROR  is one of the usual error codes listed here, 
explain-
              ing the reason for the failure).

