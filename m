Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <419DB6E1.8000203@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] AVDTP socket?
References: <418DB442.2050801@uen.org> <41925793.3050404@xmission.com>	 <1100113055.25879.73.camel@pegasus> <419543B3.8050601@xmission.com>	 <1100306337.7349.29.camel@pegasus> <41957BC1.507@xmission.com>	 <1100351199.7349.50.camel@pegasus> <41970F25.4020902@xmission.com>	 <1100446172.21403.16.camel@pegasus> <419B7292.9080706@xmission.com>	 <cbf0aec9041118052714481128@mail.gmail.com> <1100822368.7164.98.camel@pegasus>
In-Reply-To: <1100822368.7164.98.camel@pegasus>
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
Date: Fri, 19 Nov 2004 02:03:29 -0700

Marcel

I cleaned up the bitfields for the avdtp packets and committed it...

Do you think this looks right for covering the header on avdtp page 45?

// remember htobs() for converting from host to bluetooth byte ordering
// when putting data in this struct
typedef struct {
   uint8_t v:2;
   uint8_t p:1;
   uint8_t x:1;
   uint8_t cc:4;
   uint8_t m:1;
   uint8_t pt:7;
   uint16_t sequence_number;
   uint32_t timestamp;
   uint32_t ssrc;
   uint32_t csrc[0];
} __attribute__ ((packed)) media_packet_header;

If that looks like the right direction, I need to work on delineating 
the sbc frames inside the sbc file so i can put on the media packet 
headers and the media payload headers. Is it straightforward?

Brad

Marcel Holtmann wrote:
> Hi Henryk,
> 
> 
>>I'm currently working (more or less; more less than more) on SBC and
>>trying to do a decoder first because I figure that would be easier
>>(because I know what the result is supposed to look like). I have
>>problems synthesizing the PCM audio samples but can parse all of the
>>example SBC streams just fine.
>>
>>I'll attach what I have now. The sbc-test.c currently dumps subband
>>samples on stdout for testing, so just redirect that to /dev/null. The decoded
>>frame headers are written to stderr.
> 
> 
> I just tested it and the result so far is very great. Keep on working on
> it. What format do you think is the easiest to encode/decode?
> 
> And btw your file creation should be this command:
> 
> 	fh = open("bla_.au", O_WRONLY|O_CREAT|O_TRUNC, 0644);
> 
> Regards
> 
> Marcel
> 
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by: InterSystems CACHE
> FREE OODBMS DOWNLOAD - A multidimensional database that combines
> robust object and relational technologies, making it a perfect match
> for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
