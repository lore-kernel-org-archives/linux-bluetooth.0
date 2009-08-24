Return-Path: <cyrus@holtmann.org>
Message-ID: <872DF646A74B4E20906515DDCDC555C1@TSESUO>
From: "Abraham J. Velez \(EndoraSoft\)" <ajvelez@endorasoft.es>
To: <linux-bluetooth@vger.kernel.org>
Subject: Fw: Fw: Question about the connect Function and BlueZ.
Date: Mon, 24 Aug 2009 23:42:31 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=response
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

Problem Solved!!!

Part of solution is with getsockopt() to obtain the errno correct and the 
other part is the select  funcion with a control of errors.

 Thanks for your help.
Your reference of getsockopt() help us to solve the question.

 Bests Regards,
Abraham.



> ----- Original Message ----- 
> From: "David Sainty" <david.sainty@dtsp.co.nz>
> To: "Abraham J. Velez (EndoraSoft)" <ajvelez@endorasoft.es>
> Cc: <linux-bluetooth@vger.kernel.org>
> Sent: Monday, August 24, 2009 11:19 PM
> Subject: Re: Fw: Question about the connect Function and BlueZ.
>
>
>> Abraham J. Velez (EndoraSoft) wrote:
>>> Hi,
>>>
>>> The errno works but if the socket is NON-Blocking always is 115
>>> (EINPROGRESS).
>>>
>>> We need to know if the user has cancel the connexion or the connexion
>>> has broken by timeout.
>>>
>>
>> Did you read what I sent?  Especially the references to using poll() and
>> getsockopt()?
>>
>> It sounds like your problem is solved by getting the final error code
>> from connect() non-blocking?  And that's how you do it.
>>
>>>>
>>>> Does this not work?  From connect(2):
>>>>
>>>>       EINPROGRESS
>>>>              The  socket  is  non-blocking  and the connection cannot
>>>> be com-
>>>>              pleted immediately.  It is possible to select(2) or
>>>> poll(2)  for
>>>>              completion  by selecting the socket for writing. After
>>>> select(2)
>>>>              indicates writability, use getsockopt(2) to  read  the
>>>> SO_ERROR
>>>>              option  at  level SOL_SOCKET to determine whether
>>>> connect() com-
>>>>              pleted  successfully  (SO_ERROR  is  zero)   or
>>>> unsuccessfully
>>>>              (SO_ERROR  is one of the usual error codes listed here,
>>>> explain-
>>>>              ing the reason for the failure).
>>>>
>>>>
>>
>>
>
>
> --------------------------------------------------------------------------------
>
>
>
> No virus found in this incoming message.
> Checked by AVG - www.avg.com
> Version: 8.5.392 / Virus Database: 270.13.65/2323 - Release Date: 08/24/09 
> 06:05:00
> 


