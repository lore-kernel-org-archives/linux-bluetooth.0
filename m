Return-Path: <cyrus@holtmann.org>
Message-ID: <507D6F26.8040306@schulz.dk>
Date: Tue, 16 Oct 2012 16:28:54 +0200
From: Kim Schulz <kim@schulz.dk>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: gatttool and multiple devices connected
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi guys,
I was just testing the LE functionality a bit and decided to connect to 
two different LE devices at the same time using gatttool in interactive 
mode (two different terminals). Connection to the two devices went well, 
but when I tried to get primary services on the devices it was only 
possible to do so on one of the devices.
Connecting to them one by one showed that it was actually possible to 
get the primary service listing of both devices - just not when both are 
connected at the same time.
I guess this is a bug somewhere in the primary-service lookup code but 
have yet to look more into the details of this.

Just thought that you might wanted to know about this.


cheers
Kim
