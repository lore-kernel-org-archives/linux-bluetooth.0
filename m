Return-Path: <cyrus@holtmann.org>
Message-ID: <4E64AD1D.6000609@invoxia.com>
Date: Mon, 05 Sep 2011 13:06:05 +0200
From: Arnaud Mouiche <arnaud.mouiche@invoxia.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: eSCO latency configuration
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I was surprised to not see a possibility to configure the latency used 
for (e)SCO connection during creation or accept phase.

the kernel code shows simply this (in any git repo I check)

net/bluetooth/hci_conn.c: hci_setup_sync()

164 
<http://git.kernel.org/?p=linux/kernel/git/padovan/bluetooth-2.6.git;a=blob;f=net/bluetooth/hci_conn.c;h=ea7f031f3b04607efc65e79ab061dd0c5cb9337c;hb=refs/heads/master#l164> 
void hci_setup_sync(struct hci_conn *conn, __u16 handle)
165 
<http://git.kernel.org/?p=linux/kernel/git/padovan/bluetooth-2.6.git;a=blob;f=net/bluetooth/hci_conn.c;h=ea7f031f3b04607efc65e79ab061dd0c5cb9337c;hb=refs/heads/master#l165> 
{
166 
<http://git.kernel.org/?p=linux/kernel/git/padovan/bluetooth-2.6.git;a=blob;f=net/bluetooth/hci_conn.c;h=ea7f031f3b04607efc65e79ab061dd0c5cb9337c;hb=refs/heads/master#l166> 
         struct hci_dev *hdev = conn->hdev;
167 
<http://git.kernel.org/?p=linux/kernel/git/padovan/bluetooth-2.6.git;a=blob;f=net/bluetooth/hci_conn.c;h=ea7f031f3b04607efc65e79ab061dd0c5cb9337c;hb=refs/heads/master#l167> 
         struct hci_cp_setup_sync_conn cp;
168 
<http://git.kernel.org/?p=linux/kernel/git/padovan/bluetooth-2.6.git;a=blob;f=net/bluetooth/hci_conn.c;h=ea7f031f3b04607efc65e79ab061dd0c5cb9337c;hb=refs/heads/master#l168> 

169 
<http://git.kernel.org/?p=linux/kernel/git/padovan/bluetooth-2.6.git;a=blob;f=net/bluetooth/hci_conn.c;h=ea7f031f3b04607efc65e79ab061dd0c5cb9337c;hb=refs/heads/master#l169> 
         BT_DBG("%p", conn);
170 
<http://git.kernel.org/?p=linux/kernel/git/padovan/bluetooth-2.6.git;a=blob;f=net/bluetooth/hci_conn.c;h=ea7f031f3b04607efc65e79ab061dd0c5cb9337c;hb=refs/heads/master#l170> 

171 
<http://git.kernel.org/?p=linux/kernel/git/padovan/bluetooth-2.6.git;a=blob;f=net/bluetooth/hci_conn.c;h=ea7f031f3b04607efc65e79ab061dd0c5cb9337c;hb=refs/heads/master#l171> 
         conn->state = BT_CONNECT;
172 
<http://git.kernel.org/?p=linux/kernel/git/padovan/bluetooth-2.6.git;a=blob;f=net/bluetooth/hci_conn.c;h=ea7f031f3b04607efc65e79ab061dd0c5cb9337c;hb=refs/heads/master#l172> 
         conn->out = 1;
173 
<http://git.kernel.org/?p=linux/kernel/git/padovan/bluetooth-2.6.git;a=blob;f=net/bluetooth/hci_conn.c;h=ea7f031f3b04607efc65e79ab061dd0c5cb9337c;hb=refs/heads/master#l173> 

174 
<http://git.kernel.org/?p=linux/kernel/git/padovan/bluetooth-2.6.git;a=blob;f=net/bluetooth/hci_conn.c;h=ea7f031f3b04607efc65e79ab061dd0c5cb9337c;hb=refs/heads/master#l174> 
         conn->attempt++;
175 
<http://git.kernel.org/?p=linux/kernel/git/padovan/bluetooth-2.6.git;a=blob;f=net/bluetooth/hci_conn.c;h=ea7f031f3b04607efc65e79ab061dd0c5cb9337c;hb=refs/heads/master#l175> 

176 
<http://git.kernel.org/?p=linux/kernel/git/padovan/bluetooth-2.6.git;a=blob;f=net/bluetooth/hci_conn.c;h=ea7f031f3b04607efc65e79ab061dd0c5cb9337c;hb=refs/heads/master#l176> 
         cp.handle   = cpu_to_le16(handle);
177 
<http://git.kernel.org/?p=linux/kernel/git/padovan/bluetooth-2.6.git;a=blob;f=net/bluetooth/hci_conn.c;h=ea7f031f3b04607efc65e79ab061dd0c5cb9337c;hb=refs/heads/master#l177> 
         cp.pkt_type = cpu_to_le16(conn->pkt_type);
178 
<http://git.kernel.org/?p=linux/kernel/git/padovan/bluetooth-2.6.git;a=blob;f=net/bluetooth/hci_conn.c;h=ea7f031f3b04607efc65e79ab061dd0c5cb9337c;hb=refs/heads/master#l178> 

179 
<http://git.kernel.org/?p=linux/kernel/git/padovan/bluetooth-2.6.git;a=blob;f=net/bluetooth/hci_conn.c;h=ea7f031f3b04607efc65e79ab061dd0c5cb9337c;hb=refs/heads/master#l179> 
         cp.tx_bandwidth   = cpu_to_le32(0x00001f40);
180 
<http://git.kernel.org/?p=linux/kernel/git/padovan/bluetooth-2.6.git;a=blob;f=net/bluetooth/hci_conn.c;h=ea7f031f3b04607efc65e79ab061dd0c5cb9337c;hb=refs/heads/master#l180> 
         cp.rx_bandwidth   = cpu_to_le32(0x00001f40);
181 
<http://git.kernel.org/?p=linux/kernel/git/padovan/bluetooth-2.6.git;a=blob;f=net/bluetooth/hci_conn.c;h=ea7f031f3b04607efc65e79ab061dd0c5cb9337c;hb=refs/heads/master#l181> 
         cp.max_latency    = cpu_to_le16(0xffff); <<<<<< static 
configuration
182 
<http://git.kernel.org/?p=linux/kernel/git/padovan/bluetooth-2.6.git;a=blob;f=net/bluetooth/hci_conn.c;h=ea7f031f3b04607efc65e79ab061dd0c5cb9337c;hb=refs/heads/master#l182> 
         cp.voice_setting  = cpu_to_le16(hdev->voice_setting);
183 
<http://git.kernel.org/?p=linux/kernel/git/padovan/bluetooth-2.6.git;a=blob;f=net/bluetooth/hci_conn.c;h=ea7f031f3b04607efc65e79ab061dd0c5cb9337c;hb=refs/heads/master#l183> 
         cp.retrans_effort = 0xff;
184 
<http://git.kernel.org/?p=linux/kernel/git/padovan/bluetooth-2.6.git;a=blob;f=net/bluetooth/hci_conn.c;h=ea7f031f3b04607efc65e79ab061dd0c5cb9337c;hb=refs/heads/master#l184> 

185 
<http://git.kernel.org/?p=linux/kernel/git/padovan/bluetooth-2.6.git;a=blob;f=net/bluetooth/hci_conn.c;h=ea7f031f3b04607efc65e79ab061dd0c5cb9337c;hb=refs/heads/master#l185> 
         hci_send_cmd(hdev, HCI_OP_SETUP_SYNC_CONN, sizeof(cp), &cp);
186 
<http://git.kernel.org/?p=linux/kernel/git/padovan/bluetooth-2.6.git;a=blob;f=net/bluetooth/hci_conn.c;h=ea7f031f3b04607efc65e79ab061dd0c5cb9337c;hb=refs/heads/master#l186> 
}
187 
<http://git.kernel.org/?p=linux/kernel/git/padovan/bluetooth-2.6.git;a=blob;f=net/bluetooth/hci_conn.c;h=ea7f031f3b04607efc65e79ab061dd0c5cb9337c;hb=refs/heads/master#l187> 




What could be a way to add the feature without breaking any API
1) use the MTU of the socket or hdev ?
2) add hdev entry for sco latency (which can be configured with 
hciconfig like voice settings)
3) something else ...
or
4) no one cares about latency...

PS: the same way, the retransmit effort is not configurable today.

regards,
arnaud

