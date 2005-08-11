Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
From: "Morgan Rowe" <morrow@iname.com>
To: Bluez-devel@lists.sourceforge.net
Message-Id: <20050811181411.8F9861CE303@ws1-6.us4.outblaze.com>
Subject: [Bluez-devel] how to meassure BER (bit error rate)?
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
Date: Thu, 11 Aug 2005 13:14:11 -0500

Hi,

I would like to meassure the BER (bit error rate) while sending data betwen=
n two bluetooth devices.
Is it possible to meassure the BER directly or do I have to use RSSI (recei=
ved signal strengh indication)?
How can I achieve this. Can I meassure it using hcidump or hciconfig?

I learned that RSSI is an indicator for the BER, is that true and how is th=
e relationship.

Are LQ (link quality) and TPL (transmission power level) also indicators fo=
r BER?

Thanks,
Morgan

--=20
___________________________________________________________
Sign-up for Ads Free at Mail.com
http://promo.mail.com/adsfreejump.htm



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
