Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] AVDTP socket?
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <419B7292.9080706@xmission.com>
References: <418DB442.2050801@uen.org> <1099830449.6896.14.camel@pegasus>
	 <418E4E9C.8070100@xmission.com> <1099846462.6896.26.camel@pegasus>
	 <418E6FBF.3090409@xmission.com> <1099863224.6896.57.camel@pegasus>
	 <4191AB4B.8060701@xmission.com> <1100076431.25879.49.camel@pegasus>
	 <41925793.3050404@xmission.com> <1100113055.25879.73.camel@pegasus>
	 <419543B3.8050601@xmission.com> <1100306337.7349.29.camel@pegasus>
	 <41957BC1.507@xmission.com> <1100351199.7349.50.camel@pegasus>
	 <41970F25.4020902@xmission.com> <1100446172.21403.16.camel@pegasus>
	 <419B7292.9080706@xmission.com>
Content-Type: text/plain
Message-Id: <1100706753.7607.13.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 17 Nov 2004 16:52:33 +0100

Hi Brad,

> You noticed I have code to open and send a stream. When I send the 
> reference sbc streams byte-for-byte, I can hear a signal mixed with a 
> lot of noise. But then I don't know what the sbc parameters were for any 
> of the reference streams. Maybe it would just work if I knew that.
> 
> The reference decoder does not report the sbc parameters and I'm only 
> assuming that they have broken up the data and wrapped it in media 
> packet headers and sbc headers for a conservative mtu. The reference 
> encoder/decoder is undocumented and I didn't figure out how to set 
> parameters in the encoder. I don't want to spend any more time trying to 
> figure out the reference stuff.

the reference encoder/decoder has some command line options. You will
find them in "A2DP Test v10.pdf". The file format of the *.sbc is also
somewhere described. However I couldn't find it right now, but every
file contains a number of frames and all of them with a SBC header:

struct sbc_frame_header {
        uint8_t syncword:8;             /* Sync word */
        uint8_t subbands:1;             /* Subbands */
        uint8_t allocation_method:1;    /* Allocation method */
        uint8_t channel_mode:2;         /* Channel mode */
        uint8_t blocks:2;               /* Blocks */
        uint8_t sampling_frequency:2;   /* Sampling frequency */
        uint8_t bitpool:8;              /* Bitpool */
        uint8_t crc_check:8;            /* CRC check */
} __attribute__ ((packed));


Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel/listinfo/bluez-devel
