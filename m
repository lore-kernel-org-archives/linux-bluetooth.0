Return-Path: <cyrus@holtmann.org>
Message-ID: <500FD004.50309@globaledgesoft.com>
Date: Wed, 25 Jul 2012 16:22:52 +0530
From: Ajay <ajay.kv@globaledgesoft.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: SCO not maintaining connection
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


Hi,
     i got a problem with sco connection . I wanted to establish an sco 
socket connection  without using l2cap , just like an SCO client-server 
code .  Connect shows success , but after receiving few packets (raw 
audio)  programme terminates with  an error  "connection reset by peer" 
. can anyone solve this issue. since l2cap can maintain the same socket 
connection  for a long duration of time , how could the sco connection 
get disable after few seconds .


-- 
  Thanks&  regards

