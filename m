Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <8441772.1127557236734.JavaMail.Administrator@appsrv>
From: Ivy <ivy@cashette.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Voice setting for U-law and A-law.
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
Date: Sat, 24 Sep 2005 03:20:36 -0700 (PDT)

Hi Marcel,

            Thanks for your information. I wentthrought the Documentation and our Mailing list.. Please bare with me for asking this silly questions .... Still i m confused about INPUT Data Format,INput sample size and PCM BIT POSITION. Please correct me if i am wrong. I HAVE choosen in the following way.. (Right now my usb driver claimed 2nd alternate setting (isoc=2). i.e One voice connection with 16 Bit encoding & 2 Voice connection with 8 Bit encoding . 
              
          0101101000 = 0x168 

 Bitwise that"s:
 
   xxxxxx01xxxxxxxx Input Coding: u-law
   xxxxxxxx01xxxxxx Input Data Format: 2"s complement ( what is the advantage of 2's complement that 1's com ?). 
   xxxxxxxxxx1xxxxx Input Sample Size: 16 bit   ( Can i use 8 bit ?) (what does it  mean "ONly FOR Linear PCM in Documentation ?).
   xxxxxxxxxxx010xx # of bits padding at MSB: 2 (if i use 16 Bit, 2bit's of MSB is needed for padding, coz only 14bits are enough for u-law)
   xxxxxxxxxxxxxx00 Air Coding Format: CVSD


Expecting your valuable reply

Thanks
-ivy





--- Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi,
> 
> >             I am trying to change the input Encoding of Voice setting using hciconfig tool. Default voice setting 0x60, supports Linear pcm ( I guess i am newbie if any thing wrong please correct me) .. I would like to change setting to u-law or a-law. I have assigned voice setting value as 0x100 for u-law  i am not sure, it is correct or not ?.. Could any one help me to set it correctly...  
> 
> check the mailing list archive, because it was explained in detail some
> time ago and of course the specification is a good information source.
> 
> Regards
> 
> Marcel
> 
> 
> 
> 
> -------------------------------------------------------
> SF.Net email is sponsored by:
> Tame your development challenges with Apache's Geronimo App Server. 
> Download it for free - -and be entered to win a 42" plasma tv or your very
> own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel

__________________________
Free 3000MB email. Stops spam 100%. No banner ads. No popup ads. http://www.cashette.com


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
