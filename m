Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <ef9938ec0406212354177613d0@mail.gmail.com>
From: Albert Huang <ashuang@gmail.com>
To: bluez-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: [Bluez-devel] inquiry scan mode and page scan mode questions
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 22 Jun 2004 02:54:22 -0400

Hello,

I am trying to understand the bluetooth spec.  Any and all help on
these questions is greatly appreciated.  My reference is the 1.1 spec
available at www.bluetooth.org/spec

My immediate goal is to understand why 10.24 s is the recommended
duration for an inquiry, and to see if it's possible to decrease the
average time to discover a bluetooth device.  All devices are usb
bluetooth hosted on linux machines running bluez.

Is it possible, using bluez, to control how much time a device spends
in inquiry scan mode and page scan mode?  I never want to establish an
acl or sco connection to the device, just detect it and scan its name.
 If I can configure the device to spend most of its time in inquiry
scan mode, will this decrease the average inquiry response time?  What
portion of its time does an idle bluetooth device typically spend in
inquiry scan mode?

In section 10.7.2 - Inquiry Scan, the spec says "the receiver scans
for the inquiry access code long enough to completely scan for 16
frequencies".  Does this mean that it listens on one frequency at
least long enough for an inquiring device to hop frequencies 16 times?

Assuming an error-free environment, if a device A enters inquiry scan
mode and stays there, why might an inquiring device B not detect A
within a few seconds?  I'm having trouble understanding this part of
the specification (10.7.3  Inquiry):

"Like in the page substate, two 10 ms trains A and B are defined,
splitting the 32 frequencies of the inquiry hopping sequence into two
16-hop parts. A single train must be repeated for at least
Ninquiry=256 times before a new train is used. In order to collect all
responses in an error-free environment, at least three train switches
must have taken place."

I am going to paraphrase this as I understand it.  Please correct me
where I am wrong.  The 32 frequencies are split into two
non-overlapping sequences A and B of 16 channels each.  Initial
inquiries are transmitted only on the 16 channels of sequence A. 
After sequence A has been iterated through at least 256 times (2.56
seconds), the inquiry switches to sequence B and iterates through
those channels for the same amount of time.  Both sequences are
repeated once each for a total of 2.56*4 = 10.24 s.

Why must three train switches take place?  Why split the inquiry
channels into two sets and not just hop pseudorandomly through all 32
channels?


I apologize for so many general bluetooth questions that aren't
specific to bluez, but I haven't been able to find anyone able to
answer them at all.  None of the bluetooth material I've been reading
goes into enough depth to explain these questions either, as they are
mostly concerned with application-level bluetooth programming.

Thanks in advance,
Albert


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
