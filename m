Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <42855E75.6000003@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: [Bluez-devel] a2play live streaming
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
Date: Fri, 13 May 2005 20:12:05 -0600

Hi

a2play now takes args. they're possibly overly complicated, but here it is:

use: a2play [options] <bdaddr> [filename]
Where bdaddr is the bluetooth address of an A2DP headset and
filename is an audio file or device, or stdin if not specified.

Options:
  -h print this usage and exit
  -v print verbose output

  -d process input as raw audio or an audio device
  -m use mono instead of the default stereo; implies -d
  -s skip over backlogged data to try to eliminate latency; implies -d
  -r rate (hz): use rate, default 44100, for raw audio or device; implies -d

so i stream directly by running:

  a2play -s 00:0D:3C:30:32:AD /dev/dsp

unfortunately, latency is still pretty significant (~400ms?)

any ideas on how to reduce latency? i still use the ring buffer but skip 
to the last frame in the ring when using "-s" so it should never get 
behind there. the problem seems to be somewhere else anyway.

i disabled the stream close command because it locks up the itech. i got 
tired of powercycling it. let me know if it causes problems with the 
other sets.

brad


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
