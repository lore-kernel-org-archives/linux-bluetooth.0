Return-Path: <cyrus@holtmann.org>
Message-ID: <9DEA418B8D574156A6FD8FE5923922EF@TSESUO>
From: "Abraham J. Velez \(EndoraSoft\)" <ajvelez@endorasoft.es>
To: <linux-bluetooth@vger.kernel.org>
Subject: Fw: Question about the connect Function and BlueZ.
Date: Sat, 22 Aug 2009 22:50:05 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=response
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

 Thanks for you answer...

> the problem seems similar or the same to what Nick posted a view weeks
> ago. If you use blocking connect() in one thread the close() in another
> thread will not terminate the connection attempt. As far as I can tell
> this is true and should be fixed. It however works fine if you just
> would use proper non-blocking connect() with a mainloop.


 The problem of this method is the control of errors. The call to connect
 function is blocking (because we need to
 know if the user of the terminal can not connect errno==ECONNREFUSED).

 If the connect is not blocking .... i don´t know how evaluate a possible 
error. The errno haven´t the error...
(we need to know if the user rejects the connection: In the case of Obex... 
the send of the file)

 Any Idea?

 Thanks in avanced.

 Best Regards,
Abraham.



