Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <e1effdeb0710190744p5d0ddd1bxe1f4b506c985bbab@mail.gmail.com>
Date: Fri, 19 Oct 2007 11:44:31 -0300
From: "Claudio Takahasi" <cktakahasi@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <014201c78883$55aec980$8935c70a@dlh.st.com>
MIME-Version: 1.0
References: <1177608335.14980.100.camel@aeonflux.holtmann.net>
	<014201c78883$55aec980$8935c70a@dlh.st.com>
Subject: Re: [Bluez-devel] basic printing profile server?
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Does someone still interested on help me?

The objective is create a BPP server(CUPS proxy). The objects/jobs are
pushed to the desktop(BPP server), PostScripts and raw text documents
it works perfect since CUPS already supports filters for these
formats. However for XHTML-Print we have to implement a new CUPS
filter. I don't want convert XHTML-Print to PostScript inside in the
BlueZ.

The simple push model is trivial, however for the Job-Based transfer
model we need put more effort. The current prototype is able to handle
SOAP messages, but I am facing a problem: I have no idea how retrieve
a referenced image.

This is the last data received after create a job:
<?xml version="1.0" encoding="UTF-8"?>
...
        <body>
...
                <div class="page_last">

                        <div id="img_frame" class="position1">
                                <img class="img_details1"
src="obex:1120/mmc/09242007082.jpg" alt=""/>
                        </div>
                </div>
        </body>
</html>


According to the BPP spec the referenced img should be retrived using
a object channel/reverse channel, defined in the Sender's Basic
Printing Referenced Objects Service Record. But my N95 doesn't
contains any record with this UUID. How can I retrieve this img? I
tried to send a GetReferencedObjects msg in the same job
channel(instead of establish a reverse connection) but it is not
working. The printer I ordered will arrive next week only :-(

BR,
Claudio.
-- 
---------------------------------------------------------
Claudio Takahasi
Instituto Nokia de Tecnologia - INdT

On 4/27/07, Sumeet VERMA <sumeet.verma@st.com> wrote:
> Hi
> I have seen the dump of a printing application for Nokia phones (Nokia
> 6600). Its developed by nokia and HP collectively. It asks for BPP. However
> it wont work with your device if you don't support
> application/vnd.pwg-multiplexed doc format. Same goes with Nokia N Series.
>
> Regards,
> Sumeet
> -----Original Message-----
> From: bluez-devel-bounces@lists.sourceforge.net
> [mailto:bluez-devel-bounces@lists.sourceforge.net] On Behalf Of Marcel
> Holtmann
> Sent: Thursday, April 26, 2007 10:56 PM
> To: BlueZ development
> Subject: Re: [Bluez-devel] basic printing profile server?
>
> Hi Adam,
>
> > I was wondering if anyone has worked on a basic printing profile
> > server for Linux? By server, I mean a way that phones or other small
> > devices can send jobs to a Linux desktop host which would then print
> > through CUPS (or lpd, etc.).
>
> there have been ideas about it, but I can't recall an actual implementation.
> However it might happen that INdT starts working on something like this in
> the future.
>
> > It seems like a missing piece, since CUPS can already print to
> > bluetooth printers.
>
> The CUPS plugin can only print via HCRP and Serial Port Profile.
>
> > My new phone supports printing of SMS messages and photos, so before I
> > try writing a server for it, I wanted to check to see if someone has
> > done it.
>
> There are many printing profiles around. You should check which one the
> phone actually uses. Run "hcidump -X -V" and look for the profile UUID it
> requests.
>
> Regards
>
> Marcel
>

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
