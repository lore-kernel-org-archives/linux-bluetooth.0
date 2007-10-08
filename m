Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <360bc8300710080404y7f77ff4ci8da906d508ba800d@mail.gmail.com>
Date: Mon, 8 Oct 2007 08:04:21 -0300
From: "Manuel Naranjo" <naranjo.manuel@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <470A01CD.8090002@omepet.es>
MIME-Version: 1.0
References: <470A01CD.8090002@omepet.es>
Subject: Re: [Bluez-users] Problem with RFCOMM socket
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

I don't think it's a bug at all, if the status of write tells you that
the data has all ready beeing streamed, then the problem is on the
midlet side. Take into account that given the frequency bluetooth
works there's a little delay between you send the data, and the data
is received by your peer, for most applications you will not notice,
but you might for this.

What you can do is making the midlet side to close the connection, and
not regard on the bluez side. Or make the midlet send some control
stuff back to bluez so your C code closes the rfcomm after the other
peer received your data.


> Hello all,
>
> I am trying to connect BlueZ with JSR-82 with RFCOMM sockets. The BlueZ
> server creates a socket server and the JSR-82 MIDlet connects to it.
>
> It all goes well until the server sends some data and closes the socket.
> The JSR-82 program launches a "java.io.IOException: Stream closed or
> disconnected" when trying to get the number of bytes available from the
> stream. The problem can be solved by having the server call sleep(10)
> before calling close(clientSocket), giving some time for the client to
> fetch the data, but obviously it is a bad solution.
>
> This is the code:
>
> Server, C:
>
>     status = write( clientSocket, message, messageSize );
>
>     sleep(10); //Comment this for an error
>
>     close(clientSocket);
>
> Client, Java:
>
>     try
>     {
>            while ( inputStream.available() == 0)
>            {
>                 Thread.sleep(100);
>                 notifyUser("Waiting for data...");
>            }
>     }
>     catch(IOException ex)
>     {
>            notifyUser(ex.getMessage());
>     }
>
> Rest of the code is not relevant in my opinion, but I can post it if
> someone needs it to find a solution. However, it is pretty simple and
> based in http://people.csail.mit.edu/albert/bluez-intro/x502.html and
> http://developers.sun.com/mobility/midp/articles/bluetooth2/
>
> Is there something I am missing about RFCOMM sockets? Is it JSR-82
> related? Is it a bug?
>
> Thanks
>
> jm
>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc.
> Still grepping through log files to find problems?  Stop.
> Now Search log events and configuration files using AJAX and a browser.
> Download your FREE copy of Splunk now >> http://get.splunk.com/
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>


-- 
Naranjo, Manuel Francisco

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
