Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <448D9B2F.8010706@unina.it>
Date: Mon, 12 Jun 2006 18:49:51 +0200
From: Marcello Cinque <macinque@unina.it>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Content-Type: multipart/mixed; boundary="------------070509000109030605070704"
Subject: [Bluez-devel] Fwd:  hci connect and switch role modifications
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------070509000109030605070704
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Marcel,

in february I sent you the email in the following, about some proposed 
modifications in the HCI connect and switch role APIs. At that time, I also attached 
you the unified diff files, which I'm attaching also now.
Anyway, I didn't receive any reply. Do you think these modifications are 
likely to be integrated in next releases?
Thanks,
Marcello.




Subject:
Re: [Bluez-devel] hci connect and switch role modifications
From:
Capaianca <fcornevilli@gmail.com>
Date:
Tue, 21 Feb 2006 17:03:36 +0100

To:
bluez-devel@lists.sourceforge.net


Hi Marcel,

  as requested, we have attached the unified diff files of our 
modifications. Basically, we added a couple mechanisms that may use to 
prevent some errors from occurring (error masking mechanisms). The 
mechanisms are part of the results of our research on bluetooth 
networks. Perhaps the same strategies  can  be  generalized and applied  
on several parts of the code in order to improve the overall robustness 
of the BlueZ stack.

Specifically, in the hci.c file (and related hci_lib.h) we added two 
functions that may help to solve some problems which may arise when 
creating connections or when switching the role. These functions are 
called "hci_create_connection_timed" and "hci_switch_role_checked".

The hci_create_connection_timed function first creates a connection and 
then checks whether the handle is valid (>0) until a given timeout 
expires. The timeout is specified as an additional parameter, in 
milliseconds.
We created this function because, while working with bluetooth, we 
noticed that to get a valid handle over a connection may take some time, 
even after that the hci_create_connection function return, due to the 
asynchronous nature of the connection creation process. This could 
result in a error when subsequent calls are performed over the 
connection with a handle that is still not valid (e.g. a bnep create 
connection call over an already created l2cap connection, or a switch 
role command). This function avoids this problem because it returns with 
no errors only if the created connection has a valid handle.
It is worth noting that the function returns a "timer expired (ETIME)" 
error even when the connection is created. This happens when the timeout 
expires but the connection still has a not valid handle. However, the 
handle could become valid after the function exits.

The hci_switch_role_checked function performs a similar task. During our 
tests we noticed that sometimes the hci_switch_role function exits with 
a EIO error even if the role was actually switched. This problem may be 
due to a temporary bad state of the rp.status value during the switch 
role process attempt. To overcome this problem, after an invalid check 
of rp.status value, our function reads the linkmode of the connection to 
check the real status after a little amount of time (100ms in the 
current version). If the role is not switched, further attempts are made 
until a timeout expires. This timeout is provided as an input parameter 
to our function.
This function resulted particularly useful when using PDA and other 
limited resources devices where the time required to perform the switch 
role may be longer and may result in errors signaled by the original 
hci_switch_role function even if the role was actually switched.


We preferred to provide two new functions rather than modifying the 
original ones. This way the user can choose to use the function that 
better suites his requirements.

In order to test and use the new functionalities, we also slightly 
modified the hcitool.c program, so as to add an optional parameter 
"--timeout" to both the "cc" and "sr" commands. If the parameter is 
specified the new functions are called, otherwise the original functions 
are used.

Hope this can be of interest and help the BlueZ community.

Best regards,
Marcello Cinque
Fabio Cornevilli
Mobilab Research Group - www.mobilab.unina.it

Hi Marcello,

 

> we are working with Bluetooth and BlueZ since two years, and during the
> development of a field failure data analysis of Bluetooth networks, we
> experienced some annoying and frequent runtime errors that could be 
> avoided.
> Those errors concern the creation of a L2CAP connection via HCI and 
> the role
> switch operation. However, we discovered how to prevent these errors from
> occurring, by adding a little amount of code in the 
> hci_create_connection and
> hci_switch_role functions in hci.c.  
> We would like to contribute to the development and let the community 
> know and
> evaluate these modifications.
>
> If you are interested, let us know what is the procedure to contribute.
>     


simply sent a unified diff against the latest CVS to the mailing list.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log 
files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel


-- 
Il messaggio e' stato analizzato alla ricerca di virus o
contenuti pericolosi da MailScanner, ed e'
risultato non infetto.


--------------070509000109030605070704
Content-Type: application/gzip;
 name="diffiles.tar.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="diffiles.tar.gz"

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

--------------070509000109030605070704
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------070509000109030605070704
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--------------070509000109030605070704--
