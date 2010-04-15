Return-Path: <cyrus@holtmann.org>
Message-ID: <4BC723CF.5000604@ce.unipr.it>
Date: Thu, 15 Apr 2010 16:33:51 +0200
From: Paolo Medici <medici@ce.unipr.it>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Re: Implement AVCTP passthrough commands + iPod Touch
References: <20100411083333.GA10451@ce.unipr.it> <4BC1C340.50404@ce.unipr.it>
In-Reply-To: <4BC1C340.50404@ce.unipr.it>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I am currently trying bluez AVRCP on iPod Touch (3G)
It seems, however, that it respond only at the 0x44 OpCode (PASS 
THROUGH) and performs PLAY correctly.
The other codes do not give any action.


Paolo Medici wrote:
> Something like that (attached).
>
> Paolo Medici wrote:
>> Hi,
>>   Are there no contraindications to complete the implementation in 
>> audio/control.c of other commands (as well as VolumeUp/VolumeDown)?
>>   In this case, to try to control my iPod Touch, I would like to add 
>> remaining ones.
>>
>>   Paolo
>> -- 
>> To unsubscribe from this list: send the line "unsubscribe 
>> linux-bluetooth" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>


-- 
Paolo Medici - R&D
VisLab srl - P.I. 02516520349
Dipartimento di Ingegneria dell'Informazione
dell'Universita' di Parma - P.I. 00308780345
Via G.P.Usberti 181/A I-43100 Parma ITALY
Tel : +39 0521 90 5792
Web : http://vislab.it/medici

