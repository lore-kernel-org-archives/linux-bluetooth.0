Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <20050909180813.27679.qmail@web34104.mail.mud.yahoo.com>
From: Joe Samuel <sjoe2@yahoo.com>
To: Bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Subject: [Bluez-devel] SBC encoding Wav files
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
Date: Fri, 9 Sep 2005 19:08:13 +0100 (BST)

Hi,
Why is the sbc code accepting only au?
I tried a PCM wav file, changed the endianness here:
for (ch = 0; ch < sbc->channels; ch++) {
			int16_t s = *((short *)ptr);
			ptr += 2;
			priv->frame.pcm_sample[ch][i] = s;
		}

And of course, changed the header reading part; but it
looks like things are not as simple as that. The
encoded file sounds horrible (rather I would say, it
had nothing in it that sounds like the original).
Did I miss out something?

regards,
Joe





	
	
		
___________________________________________________________ 
Yahoo! Messenger - NEW crystal clear PC to PC calling worldwide with voicemail http://uk.messenger.yahoo.com


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
