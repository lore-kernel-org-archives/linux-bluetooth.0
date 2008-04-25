Return-Path: <cyrus@holtmann.org>
Message-ID: <b5b2e67c0804250005w3101239dk9156a891c43ea712@mail.gmail.com>
Date: Fri, 25 Apr 2008 08:05:54 +0100
From: "Heston James" <hestonjames@googlemail.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-devel] Understanding my available resources
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0221927728=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============0221927728==
Content-Type: multipart/alternative;
	boundary="----=_Part_514_18678649.1209107154749"

------=_Part_514_18678649.1209107154749
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Good morning all,

I'm new to the list, whilst I have been working with bluez for a little
while now I have a few questions I'm itching to ask so thought it was about
time that I subscribed and made some noise :-)

I'm looking for some help in understanding what 'resources' (if that's the
right term) I have available to me. I'll try and list my questions below in
the hope that you'll understand what I'm asking.

1) As I understand it, A bluetooth dongle has 7 available ACL connections,
is that correct?
2) These available ACL connections are consumed by most tasks such as
Inquiry Scans, SDP Enquiries, RFCOMM connections and suchlike, is that
right?
3) Can I, using the dbus API see how many ACL connections are currently
being consumed on the adapter? If not through the dbus API can I do it
through the lower level API?

The reason I ask is that I believe I can build more effective applications
on top of bluez if I can understand what resources are available to me. For
instance, I have noticed that when performing a Periodic Enquiry on an
adapter, if I use that same adapter to do an SDP Enquiry on a remote device
then it seems to halt my periodic enquiry, is that normal behaviour? or
perhaps just wrong coding on my part?

Also, as another example, when I try and perform a couple of SDP enquiries
through an adapter on a couple of remote devices concurrently then usualy
one or both enquiries will fail with something like a 'devcie or resource
busy' exception.

If both of those cases are true then I feel it would be beneficial for me to
be able to manage my resources more effectively and ensure my application
doesn't SDP on an adapter which is performing an enquiry, or put some type
of locking on my SDP enquiry calls so I'm never performing more than 1 at a
time.

I look forward to getting your thoughts on this guys, whilst a fairly
competent bluez developer this little conundrum has always escaped me. I'm
really intreagued to understand what resources are available on a dongle and
exactly how particular processes such as Enquiries and SDP's consume them.

Many thanks,

Heston

p.s. Excellent work on the stack guys, really excelent!

------=_Part_514_18678649.1209107154749
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Good morning all,<br>&nbsp;<br>I&#39;m new to the list, whilst I have been working with bluez for a little while now I have a few questions I&#39;m itching to ask so thought it was about time that I subscribed and made some noise :-)<br>
&nbsp;<br>I&#39;m looking for some help in understanding what &#39;resources&#39; (if that&#39;s the right term) I have available to me. I&#39;ll try and list my questions below in the hope that you&#39;ll understand what I&#39;m asking.<br>
&nbsp;<br>1) As I understand it, A bluetooth dongle has 7 available ACL connections, is that correct?<br>2) These available ACL connections are consumed by most tasks such as Inquiry Scans, SDP Enquiries, RFCOMM connections and suchlike, is that right?<br>
3) Can I, using the dbus API see how many ACL connections are currently being consumed on the adapter? If not through the dbus API can I do it through the lower level API?<br>&nbsp;<br>The reason I ask is that I believe I can build more effective applications on top of bluez if I can understand what resources are available to me. For instance, I have noticed that when performing a Periodic Enquiry on an adapter, if I use that same adapter to do an SDP Enquiry on a remote device then it seems to halt my periodic enquiry, is that normal behaviour? or perhaps just wrong coding on my part?<br>
&nbsp;<br>Also, as another example, when I try and perform a couple of SDP enquiries through an adapter on a couple of remote devices concurrently then usualy one or both enquiries will fail with something like a &#39;devcie or resource busy&#39; exception.<br>
&nbsp;<br>If both of those cases are true then I feel it would be beneficial for me to be able to manage my resources more effectively and ensure my application doesn&#39;t SDP on an adapter which is performing an enquiry, or put some type of locking on my SDP enquiry calls so I&#39;m never performing more than 1 at a time.<br>
&nbsp;<br>I look forward to getting your thoughts on this guys, whilst a fairly competent bluez developer this little conundrum has always escaped me. I&#39;m really intreagued to understand what resources are available on a dongle and exactly how particular processes such as Enquiries and SDP&#39;s consume them.<br>
&nbsp;<br>Many thanks,<br>&nbsp;<br>Heston<br>&nbsp;<br>p.s. Excellent work on the stack guys, really excelent!

------=_Part_514_18678649.1209107154749--


--===============0221927728==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
--===============0221927728==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0221927728==--
