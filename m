Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: libo <libo@semit.com.cn>
To: bluez-users@lists.sourceforge.net
Message-Id: <20041019184254.31606ee9.libo@semit.com.cn>
In-Reply-To: <1098107316.21553.8.camel@pegasus>
References: <34204.81.199.88.27.1098106921.squirrel@ucu.ac.ug>
	<1098107316.21553.8.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: [Bluez-users] Student query: a question about multihop
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Tue, 19 Oct 2004 18:42:54 +0800

                       +---------+
                       |   GN      |
                       +---------+
                     /             \
                    /                \
                   /                  \
                  /                     \
              +--------+         +--------+
              | PANU 1 |          | PANU 2|
              +--------+         +--------+
I did as the HOWTO-PAN.txt said.
GN connect with PANU1 with bnep0 and PANU1 with bnep1. I have to allocate IPs for both of bnep0 (10.0.0.1) and bnep1 (10.0.1.1), thus PANU1 (10.0.0.2) and PANU2 (10.0.1.2) are in different subnet, and they can not ping each other.
I may have done something wrong. It is unrealistic to allocate IP for each bnep if there are more PANUs connect to the GN. I think there must be a better way to let those PANUs in the same subnet, and one can access the other through GN easily.
Thank you for your advice.



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
