Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <43220D8C.2040103@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] SBC encoding Wav files
References: <20050909180813.27679.qmail@web34104.mail.mud.yahoo.com> <000a01c5b571$377ba870$0201a8c0@NBVICTOR>
In-Reply-To: <000a01c5b571$377ba870$0201a8c0@NBVICTOR>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Fri, 09 Sep 2005 16:32:44 -0600

hey

we just have a reference encoder. use another tool to convert to .au 
first. i'm not sure it's worth the effort to add more formats to the 
encoder when it's just for development.

to reiterate: we want the encoder to work transparently as a plugin 
inside alsa. maybe i'll be able to get back to that now.

brad

Victor Shcherbatyuk wrote:
> Joe,
> 
> If .pcm works and .wav doesn't, must be something with audio parameters 
> extracted from wav header? I've never tried wav's and the earliest I can 
> is the week after the next week... May be Brad has some ideas?
> 
> Regards,
>    Victor.
> 
> ----- Original Message ----- From: "Joe Samuel" <sjoe2@yahoo.com>
> To: <Bluez-devel@lists.sourceforge.net>
> Sent: Friday, September 09, 2005 20:08
> Subject: [Bluez-devel] SBC encoding Wav files
> 
> 
>> Hi,
>> Why is the sbc code accepting only au?
>> I tried a PCM wav file, changed the endianness here:
>> for (ch = 0; ch < sbc->channels; ch++) {
>> int16_t s = *((short *)ptr);
>> ptr += 2;
>> priv->frame.pcm_sample[ch][i] = s;
>> }
>>
>> And of course, changed the header reading part; but it
>> looks like things are not as simple as that. The
>> encoded file sounds horrible (rather I would say, it
>> had nothing in it that sounds like the original).
>> Did I miss out something?
>>
>> regards,
>> Joe
>>
>>
>>
>>
>>
>>
>>
>>
>> ___________________________________________________________
>> Yahoo! Messenger - NEW crystal clear PC to PC calling worldwide with 
>> voicemail http://uk.messenger.yahoo.com
>>
>>
>> -------------------------------------------------------
>> SF.Net email is Sponsored by the Better Software Conference & EXPO
>> September 19-22, 2005 * San Francisco, CA * Development Lifecycle 
>> Practices
>> Agile & Plan-Driven Development * Managing Projects & Teams * Testing 
>> & QA
>> Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
>> _______________________________________________
>> Bluez-devel mailing list
>> Bluez-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/bluez-devel 
> 
> 
> 
> 
> -------------------------------------------------------
> SF.Net email is Sponsored by the Better Software Conference & EXPO
> September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
> Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
> Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
