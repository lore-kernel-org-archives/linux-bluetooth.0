Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <4322155A.9040503@gulik.org>
From: Gregory Gulik <greg@gulik.org>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Trouble with D-LINK adapter w/Treo 650 and FC4
References: <430D4681.80609@gulik.org> <1124996595.8019.58.camel@pegasus>	<430F2C70.5090601@gulik.org>  <4321F221.3030604@gulik.org>	<1126299854.5269.3.camel@blade>  <432202D1.90102@gulik.org> <1126306974.5269.5.camel@blade>
In-Reply-To: <1126306974.5269.5.camel@blade>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Fri, 09 Sep 2005 18:06:02 -0500

The howto I followed originally already had me enable authentication and 
encryption in the hcid.conf:

         # Authentication and Encryption (Security Mode 3)
         auth enable;
         encrypt enable;


Marcel Holtmann wrote:
> read the specs. and you set auth and encrypt in hcid.conf. Don't do this
> until you know what this implies.

-- 
Greg Gulik                                 http://www.gulik.org/greg/
greg @ gulik.org



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
