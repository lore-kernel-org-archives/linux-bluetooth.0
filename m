Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <57c68ddc0702190128n149fa456if5bc854aca1574a0@mail.gmail.com>
References: <57c68ddc0702190128n149fa456if5bc854aca1574a0@mail.gmail.com>
Date: Mon, 19 Feb 2007 11:45:36 +0100
Message-Id: <1171881936.26567.14.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Help needed for setting up multiple
	connection	using single bluetooth adapter
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

Hi Siddhant,

>    I have already posted few mails regarding before ,also tried
> different things at my end  , but things didnt went anywhere. Now
> setting up and using this feature has become a necessity for my
> project so i would be making more effort from now on. 
> 
> The first question that i have is  ---- What is the procedure for
> doing such a thing , till now what i have tried can be summarized as
> below :- 
> 
> i) Fork two different processes. 
> 
> ii) For each process establish RFCOMM connection via socket call.
> 
> iii) For each RFCOMM port perform OBEX_PUSH by registering a custom
> protocol.
> 
> The above method works fine for single process but when in multiply
> process mode few unexpected things happen which are :- 
> 
> i) Sometimes one process waits for the other to get completed.
> ii) One of the processes errors out.

first of all run "hcidump -X -V" to see what actually happens with the
Bluetooth adapter and second, you have to get the forking and process
handling right. Otherwise you better use an event loop.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
