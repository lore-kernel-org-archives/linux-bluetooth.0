Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <448F0E0A.7020308@stfw.eu>
Date: Tue, 13 Jun 2006 20:12:10 +0100
From: Zhares <ml-sourceforge@stfw.eu>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
References: <1150148335.7372.7.camel@johannes_01.kapune.local>	<448DEA20.5000806@stfw.eu>
	<1150219383.7401.5.camel@johannes_01.kapune.local>
In-Reply-To: <1150219383.7401.5.camel@johannes_01.kapune.local>
Subject: Re: [Bluez-users] Can't play mp3, what I'm missing?
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi

Johannes Kapune wrote:

> When I have changed the hcid.conf, what to do to use the changes?


try to replace the line :
    security auto;

by:
    security user;
or:
    security none;

here is an extract of the hcid,conf that was installed with ubuntu:

         # Security Manager mode
         #   none - Security manager disabled
         #   auto - Use local PIN for incoming connections
         #   user - Always ask user for a PIN
         #


-- 

      Zhares


_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
