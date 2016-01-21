Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 21 Jan 2016 16:33:58 +0530
Message-ID: <CAKafyqrZNx9RPznO3Skon3hzV=AnXSuP4v0nucuS2mESpxdoEw@mail.gmail.com>
Subject: Creating a separate event node for each device composite
From: Prabhu Chawandi <foss.chaws@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

  Is it possible to make Linux to create a separate /dev/input/eventX
node for all the device composited ?

Example: if my device is supporting Mouse, KBD and Consumer

if I want to create three event nodes for each, like /dev/input/event1
/dev/input/event2 /dev/input/event3.

is it allowed in BT HIDP ? Please help me to understand..

thanks in advance.
Prabhu Chawandi
