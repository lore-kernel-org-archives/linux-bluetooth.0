Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: bugzilla-daemon@bugzilla.kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 188551] New: Function bpa10x_send_frame() does not return a
 negative error code when the call to usb_submit_urb() fails.
Date: Fri, 25 Nov 2016 10:32:49 +0000
Message-ID: <bug-188551-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=188551

            Bug ID: 188551
           Summary: Function bpa10x_send_frame() does not return a
                    negative error code when the call to usb_submit_urb()
                    fails.
           Product: Drivers
           Version: 2.5
    Kernel Version: linux-4.9-rc6
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: bianpan2010@ruc.edu.cn
        Regression: No

In function bpa10x_send_frame() defined in file drivers/bluetooth/bpa10x.c,
variable err takes the error code. When the call to usb_submit_urb() (at line
349) fails, a negative integer should be returned. However, it returns 0, which
indicates that there is no error. Maybe it is better to "return err;" instead
of "return 0;" at line 358. Codes related to this bug are summarised as
follows.

283 static int bpa10x_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
284 {
285     struct bpa10x_data *data = hci_get_drvdata(hdev);
286     struct usb_ctrlrequest *dr;
287     struct urb *urb;
288     unsigned int pipe;
289     int err;
290 
291     BT_DBG("%s", hdev->name);
292 
293     skb->dev = (void *) hdev;
294 
295     urb = usb_alloc_urb(0, GFP_ATOMIC);
296     if (!urb)
297         return -ENOMEM;
        ...
349     err = usb_submit_urb(urb, GFP_ATOMIC);
350     if (err < 0) {
351         BT_ERR("%s urb %p submission failed", hdev->name, urb);
352         kfree(urb->setup_packet);
353         usb_unanchor_urb(urb);
354     }
355 
356     usb_free_urb(urb);
357 
358     return 0;      // return err?
359 }

Thanks very much!

-- 
You are receiving this mail because:
You are the assignee for the bug.
