Return-Path: <cyrus@holtmann.org>
Subject: Attribute Server and Client TODOs
From: Brian Gix <bgix@codeaurora.org>
To: claudio.takahasi@openbossa.org
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 21 Jan 2011 16:07:56 -0800
Message-ID: <1295654876.1774.24.camel@ubuntuLab1>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio, etc,

Sorry for the repeat --> I sent it to the incorrect list the first time.

We are starting to look at the adopted LE profiles, and it is becoming
clear that Higher layer (Applications etc) server support will be needed
for some of the significant use cases such as Proximity.  Is anybody
currently working on a D-Bus interface to the Attribute Server?  I know
there is nothing in code that has been up-streamed yet, but I was
wondering if anyone has put some thought into what a D-Bus interface for
the Attribute Server might look like?

Also, one of my compatriots is telling me that she cannot get the GATT
Client D-Bus interface to work.  I don't know if this is a simple lack
of Introspection Data (required by d-feet), or if there is a build or
configuration parameter that needs to be setup.  I have just been using
the gatttool to run my tests, and not going through D-Bus.  If anybody
has been using D-Bus for GATT Client testing, I would be interested in
finding out if there is some setup requirements that I am missing.


Thanks for your time.


-- 
Brian Gix
bgix@codeaurora.org
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum

