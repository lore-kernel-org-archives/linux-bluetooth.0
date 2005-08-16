Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] how to meassure BER (bit error rate)?
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <20050811181411.8F9861CE303@ws1-6.us4.outblaze.com>
References: <20050811181411.8F9861CE303@ws1-6.us4.outblaze.com>
Content-Type: text/plain
Message-Id: <1124206242.7466.11.camel@pegasus>
Mime-Version: 1.0
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
Date: Tue, 16 Aug 2005 17:30:42 +0200

Hi Morgan,

> I would like to meassure the BER (bit error rate) while sending data betwenn two bluetooth devices.
> Is it possible to meassure the BER directly or do I have to use RSSI (received signal strengh indication)?
> How can I achieve this. Can I meassure it using hcidump or hciconfig?
> 
> I learned that RSSI is an indicator for the BER, is that true and how is the relationship.
> 
> Are LQ (link quality) and TPL (transmission power level) also indicators for BER?

with the CSR chips you can use the link quality and extract the BER
value. The tables for that are on my website.

Regards

Marcel




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
