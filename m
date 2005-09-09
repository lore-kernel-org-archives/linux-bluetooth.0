Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <4321EE6B.80406@juletraesfoden.dk>
From: Thomas <tm@juletraesfoden.dk>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-users] Motorola DC800, and Motorola HT820
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
Date: Fri, 09 Sep 2005 22:19:55 +0200

Got myself a headset (Motorola HT820) and the accompanying audio source 
(DC800)

Just for fun, I thought that I would like to stream some audio from my 
server, to either one of them. But so far I haven't been able to do it 
with a2play. apparently it starts up fine, but I don't hear any audio. I 
have attached dump from a2play for refference (this is the DC800 that I 
try to stream to).

the a2play is from the CVS (I removed pthread support, as it apparently 
was broken in my setup, as it barfed about pthread_create and pthread_join)

Any pointers?

/ Thomas
------ DUMP a2play -------
len=2048
Header size=28
Sample Rate:44100
Channels:2
Using address: 00:07:A4:D5:51:1B
Found A2DP Sink
Found A2DP Sink

Found A2DP Sink at the destination
Connected [imtu 672, omtu 895, flush_to 65535]

Sent the Stream End Point Discovery Command
Got a Stream End Point Discovery Response
received 2 capabilities

SEID = 3
Requested Capabilities for SEID = 3
Got capabilities response
Sent set configurations command
Set configurations command accepted
Sent open stream command
Connected [imtu 672, omtu 895, flush_to 65535]
Got open stream confirm
Sent stream start





-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
