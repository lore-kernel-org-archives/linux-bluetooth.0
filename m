Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Request for Long Write/Read details 
From: Travis Griggs <travisgriggs@gmail.com>
In-Reply-To: <812914A8-66C2-4343-8A1B-FB6EC1905DFE@gmail.com>
Date: Thu, 14 Jul 2016 12:45:16 -0700
Message-Id: <4C79489C-B20A-43F6-BDF2-10CF71FF70E2@gmail.com>
References: <1468500345-5833-1-git-send-email-luiz.dentz@gmail.com> <812914A8-66C2-4343-8A1B-FB6EC1905DFE@gmail.com>
To: linux-bluetooth@vger.kernel.org
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I noticed vestiges of the new options parameter in the 5.40 APIs being able to support long reads/writes. There doesn’t seem to be anything in test directory that demonstrates how these can be utilized.

I’m only vaguely familiar with how these long read/writes work. I’m curious which parts I as the programmer do, and which parts the stack does for me. If I just issue a ValueChanged with an array longer than 20, does it automatically break it up into multiple writes with the start/stop values appropriately attached? I’d be curious what I do in my iOS app to see the WriteValue light up with those options indicating the start/stop of each segment.

I’m particularly curious about this, given the performance I’m seeing using a scheme I concocted myself for streaming arbitrary length packets over the characteristics.

